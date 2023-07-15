//
//  MySavedBakeryViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MySavedBakeryViewController: BaseViewController {
    
    // MARK: - Property
    
    enum Section {
        case main, empty
    }
    typealias DataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
    private var dataSource: DataSource?
    private var savedList: [BakeryListResponseDTO] = BakeryListResponseDTO.item
    private var currentSection: [Section] = [.empty]
    
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    // MARK: - UI Property
    
    private let naviView = CustomNavigationBar()
    private let lineView = LineView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegistration()
        setDataSource()
        setReloadData()
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        
        view.addSubviews(naviView, collectionView)
        naviView.addSubview(lineView)
        
        naviView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalTo(safeArea)
        }
        
        lineView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.bottom.equalToSuperview()
            
        }
    }
    
    override func setUI() {
        naviView.do {
            $0.addBackButtonAction(UIAction { _ in
                dump(self.navigationController)
                self.navigationController?.popViewController(animated: true)
            })
            $0.configureLeftTitle(to: I18N.MySavedBakery.naviTitle)
        }
    }
    
    private func setRegistration() {
        collectionView.register(cell: BakeryListCollectionViewCell.self)
        collectionView.register(cell: EmptyCollectionViewCell.self)
    }
    
    private func setDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let section = self.dataSource?.snapshot().sectionIdentifiers[indexPath.section]
            switch section {
            case .main:
                let cell: BakeryListCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.getViewType(.defaultType)
                if let bakeryListItem = item as? BakeryListResponseDTO {
                    cell.updateUI(data: bakeryListItem, index: indexPath.item)
                }
                return cell
            case .empty, .none:
                let cell: EmptyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.getViewType(.noBookmark)
                return cell
            }
        })
    }
    
    private func setReloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        defer { dataSource?.apply(snapshot, animatingDifferences: false)}
        snapshot.appendSections([.main])
        snapshot.appendItems(savedList)
    }
    
    private func updateDataSource(data: BakeryListResponseDTO) {
        guard var snapshot = dataSource?.snapshot() else { return }
        if data.bookmarkCount == 0 {
            snapshot.deleteSections(currentSection)
            snapshot.appendItems([0], toSection: .empty)
            currentSection = [.empty]
            dataSource?.apply(snapshot)
        } else {
            snapshot.deleteSections(currentSection)
            snapshot.appendItems(savedList, toSection: .main)
            currentSection = [.main]
            dataSource?.apply(snapshot)
        }
    }
    
    private func layout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvirnment  in
            let section = self.dataSource?.snapshot().sectionIdentifiers[sectionIndex]
            switch section {
            case .main:
                var config = UICollectionLayoutListConfiguration(appearance: .plain)
                config.backgroundColor = .clear
                config.showsSeparators = true
                
                let layoutSection = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvirnment)
                return layoutSection
            case .empty, .none:
                return self.normalSection()
            }
        }
        
        return layout
    }
    
    private func normalSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            ),
            subitem: item,
            count: 1
        )
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}
