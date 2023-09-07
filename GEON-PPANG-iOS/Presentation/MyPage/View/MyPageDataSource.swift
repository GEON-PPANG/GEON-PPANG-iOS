//
//  MyPageDataSource.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/08/28.
//

import UIKit

final class MyPageDataSource: DiffableDataSourceProtocol {
    
    typealias ProfileCell = MyPageProfileCell
    typealias BasicCell = MyPageBasicCell
    typealias Footer = MyPageCollectionViewFooter
    typealias CellRegistration = UICollectionView.CellRegistration
    typealias FooterRegistration = UICollectionView.SupplementaryRegistration
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, UUID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, UUID>
    typealias Action = (() -> Void)
    
    enum Section: Int, CaseIterable {
        case profile = 0
        case general = 1
        case version = 2
        case leave = 3
        
        var contentCount: Int {
            switch self {
            case .profile: return 1
            case .general: return 2
            case .version: return 1
            case .leave: return 1
            }
        }
    }
    
    // MARK: - Property
    
    var memberData: MyPageResponseDTO
    
    var filterButtonTapped: Action?
    var savedBakeryTapped: Action?
    var myReviewsTapped: Action?
    
    //    var logoutTapped: Action?
    var leaveTapped: Action?
    
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
        
        collectionView.register(header: ProfileCell.self)
        collectionView.register(cell: BasicCell.self)
        collectionView.register(footer: Footer.self)
        
        collectionView.collectionViewLayout = createLayout()
    }
    
    func setDataSource() {
        
        let profileCellRegistration = CellRegistration<ProfileCell, MyPageResponseDTO> { cell, _, model in
            cell.configureMemberData(to: model)
            cell.filterButtonTapped = self.filterButtonTapped
            cell.savedBakeryTapped = self.savedBakeryTapped
            cell.myReviewsTapped = self.myReviewsTapped
        }
        let basicCellRegistration = CellRegistration<BasicCell, MyPageModel> { cell, _, model in
            cell.configureTitle(to: model.title)
        }
        let footerRegistration = FooterRegistration<Footer>(elementKind: footerType) { footer, _, _ in
            footer.leaveTapepd = self.leaveTapped
        }
        
        dataSource = DiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, _ in
            guard let sectionType = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }

            switch sectionType {
            case .profile:
                return collectionView.dequeueConfiguredReusableCell(using: profileCellRegistration, for: indexPath, item: self.memberData)
            case .general:
                return collectionView.dequeueConfiguredReusableCell(using: basicCellRegistration, for: indexPath, item: MyPageModel.general[indexPath.item])
            case .leave:
                return collectionView.dequeueConfiguredReusableCell(using: basicCellRegistration, for: indexPath, item: MyPageModel.leave[indexPath.item])
            case .version:
                let cell = collectionView.dequeueConfiguredReusableCell(using: basicCellRegistration, for: indexPath, item: MyPageModel.version[indexPath.item])
                cell.configureAppVersion()
                return cell
            }
        })
        
        dataSource.supplementaryViewProvider = { collectionView, _, indexPath in
            guard indexPath.section == 3 else { return nil }
            return collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: indexPath)
        }
    }
    
    func loadData() {
        
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems([UUID()], toSection: .profile)
        snapshot.appendItems([UUID(), UUID()], toSection: .general)
        snapshot.appendItems([UUID()], toSection: .version)
        snapshot.appendItems([UUID()], toSection: .leave)
        dataSource.applySnapshotUsingReloadData(snapshot)
    }
    
}

extension MyPageDataSource {
    
    private func createLayout() -> UICollectionViewLayout {
        
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            guard let sectionType = Section(rawValue: sectionIndex) else { return nil }
            
            let count = self.memberData.breadType.configureTrueOptions().count
            let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.15))
            let footerAlignmnet = NSRectAlignment.bottom
            let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: self.footerType, alignment: footerAlignmnet)
            
            let group = self.group(of: sectionIndex)
            
            let section = NSCollectionLayoutSection(group: group)
            switch sectionType {
            case .profile, .version:
                section.contentInsets = .init(top: 0, leading: 0, bottom: 12, trailing: 0)
            case .general:
                section.contentInsets = .init(top: 0, leading: 0, bottom: 4, trailing: 0)
            case .leave:
                section.boundarySupplementaryItems = [footer]
            }
            return section
        }
    }
    
    private func group(of section: Int) -> NSCollectionLayoutGroup {
        
        var itemSize: NSCollectionLayoutSize
        var item: NSCollectionLayoutItem
        var groupSize: NSCollectionLayoutSize
        var group: NSCollectionLayoutGroup
        
        let basicItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(56))
        let count = memberData.breadType.configureTrueOptions().count
        
        guard let sectionType = Section(rawValue: section)
        else { return .init(layoutSize: .init(widthDimension: .absolute(0), heightDimension: .absolute(0))) }
        
        switch sectionType {
        case .profile:
            itemSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(count <= 3 ? 288 : 319))
            item = .init(layoutSize: itemSize)
            groupSize = itemSize
            group = .vertical(layoutSize: groupSize, subitems: [item])
        case .general:
            item = .init(layoutSize: basicItemSize)
            groupSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(56 * 2))
            group = .vertical(layoutSize: groupSize, subitems: [item, item])
        case .version, .leave:
            item = .init(layoutSize: basicItemSize)
            group = .vertical(layoutSize: basicItemSize, subitems: [item])
        }
        
        return group
    }
}
