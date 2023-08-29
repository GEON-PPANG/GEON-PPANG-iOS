//
//  MyPageDataSource.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/08/28.
//

import UIKit

final class MyPageDataSource: DiffableDataSourceProtocol {
    
    typealias Header = MyPageCollectionViewHeader
    typealias Footer = MyPageCollectionViewFooter
    typealias Cell = MyPageCollectionViewCell
    typealias Model = MyPageModel
    typealias SuppleRegistration = UICollectionView.SupplementaryRegistration
    typealias CellRegistration = UICollectionView.CellRegistration
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, Model.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Model.ID>
    
    enum Section: Int, CaseIterable {
        case general = 0
        case version = 1
        
        var contentCount: Int {
            switch self {
            case .general: return 2
            case .version: return 1
            }
        }
    }
    
    // MARK: - Property
    
    var memberData: MyPageResponseDTO
    var nextButtonTapped: (() -> Void)?
    var savedBakeryTapped: (() -> Void)?
    var myReviewsTapped: (() -> Void)?
    
    // MARK: - UI Property
    
    var dataSource: DiffableDataSource!
    private let collectionView: UICollectionView
    
    // MARK: - Life Cycle
    
    init(_ collectionView: UICollectionView, _ memberData: MyPageResponseDTO) {
        self.collectionView = collectionView
        self.memberData = memberData
        
        setCollectionView()
        setDataSource()
        loadData()
    }
    
    // MARK: - Setting
    
    func setCollectionView() {
        
        collectionView.register(header: Header.self)
        collectionView.register(footer: Footer.self)
        collectionView.register(cell: Cell.self)
        
        collectionView.collectionViewLayout = createLayout()
    }
    
    func setDataSource() {
        
        let cellRegistration = CellRegistration<Cell, MyPageModel> { cell, _, model in
            cell.configureTitle(to: model.title)
        }
        let headerRegistration = SuppleRegistration<Header>(elementKind: headerType) { header, _, _ in
            header.configureMemberData(to: self.memberData)
            header.nextButtonTapped = self.nextButtonTapped
            header.savedBakeryTapped = self.savedBakeryTapped
            header.myReviewsTapped = self.myReviewsTapped
        }
        let footerRegistration = SuppleRegistration<Footer>(elementKind: footerType, handler: { _, _, _ in return })
        
        dataSource = DiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, _ in
            let content: [MyPageModel] = MyPageModel.general + MyPageModel.version
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: content[indexPath.item])
        })
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            switch kind {
            case self.headerType:
                return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
            case self.footerType:
                return collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: indexPath)
            default: return nil
            }
        }
    }
    
    func loadData() {
        
        let data = [MyPageModel.general, MyPageModel.version]
        var snapshot = Snapshot()
        Section.allCases.forEach {
            snapshot.appendSections([$0])
            snapshot.appendItems(data[$0.rawValue].map { $0.id })
        }
        dataSource.applySnapshotUsingReloadData(snapshot)
    }
    
}

extension MyPageDataSource {
    
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            
            guard let sectionType = Section(rawValue: sectionIndex) else { return nil }
            let contentCount = sectionType.contentCount
            
            let header = self.supplementaryItem(of: self.headerType)
            let footer = self.supplementaryItem(of: self.footerType)
            let group = self.group(withSize: contentCount)
            
            let section = NSCollectionLayoutSection(group: group)
            switch sectionType {
            case .general:
                section.contentInsets = .init(top: 12, leading: 0, bottom: 4, trailing: 0)
                section.boundarySupplementaryItems = [header]
            case .version:
                section.contentInsets = .init(top: 0, leading: 0, bottom: 12, trailing: 0)
                section.boundarySupplementaryItems = [footer]
            }
            return section
        }
        return layout
    }
    
    private func group(withSize count: Int) -> NSCollectionLayoutGroup {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(56))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupHeight = NSCollectionLayoutDimension.absolute(CGFloat(56 * count))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        return group
    }
    
    private func supplementaryItem(of type: String) -> NSCollectionLayoutBoundarySupplementaryItem {
        
        var size: NSCollectionLayoutSize
        var alignment: NSRectAlignment
        
        var headerFilterCount = 0
        let trueOptions = memberData.breadType.configureTrueOptions()
        trueOptions.forEach { headerFilterCount += $0.0.count }
        
        switch type {
        case headerType:
            let height: CGFloat = headerFilterCount <= 15 ? 288 : 319
            size = .init(widthDimension: .fractionalWidth(1),
                         heightDimension: .absolute(height))
            alignment = .top
        case footerType:
            size = .init(widthDimension: .fractionalWidth(1),
                         heightDimension: .absolute(104))
            alignment = .bottom
        default:
            size = .init(widthDimension: .absolute(0),
                         heightDimension: .absolute(0))
            alignment = .none
        }
        
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: size,
                                                           elementKind: type,
                                                           alignment: alignment)
    }
}
