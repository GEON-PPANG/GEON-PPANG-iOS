//
//  SearchViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/09.
//

import UIKit

import SnapKit
import Then

final class SearchViewController: BaseViewController {
    
    // MARK: - Property
    
    enum Section {
        case initial, main, empty
    }
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    typealias Item = AnyHashable
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    private var dataSource: DataSource?
    private let bakeryList: [HomeBestBakeryResponseDTO] = HomeBestBakeryResponseDTO.item
    
    // MARK: - UI Property
    
    private let naviView = SearchNavigationView()
    private let searchResultView = SearchResultView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    // MARK: - Setting
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegister()
        setupDataSource()
        setReloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    override func setLayout() {
        view.addSubviews(naviView, searchResultView, collectionView)
        
        naviView.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(convertByHeightRatio(68))
        }
        
        searchResultView.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(convertByHeightRatio(55))
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchResultView.snp.bottom)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setUI() {
        naviView.do {
            $0.dismissClosure = {
                self.navigationController?.popViewController(animated: true)
            }
        }
        searchResultView.do {
            $0.updateUI(count: 3)
            $0.isHidden = true
        }
        collectionView.do {
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
        }
    }
    
    private func setRegister() {
        collectionView.register(cell: EmptyCollectionViewCell.self)
        collectionView.register(cell: SearchCollectionViewCell.self)
    }
    
    private func setupDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, _ in
            let section = self.dataSource?.snapshot().sectionIdentifiers[indexPath.section]
            switch section {
            case .initial:
                let cell: EmptyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.getViewType(.initialize)
                return cell
            case .empty:
                let cell: EmptyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.getViewType(.noSearch)
                return cell
            case .main, .none:
                let cell: SearchCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                return cell
            }
        })
    }
    
    private func setReloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        defer { dataSource?.apply(snapshot, animatingDifferences: false)}
        snapshot.appendSections([.initial])
        snapshot.appendItems([0])
    }
    
    private func setDataSource(data: [HomeBestBakeryResponseDTO]) {
        guard var snapshot = dataSource?.snapshot() else { return}
        if data.count == 0 {
            snapshot.appendItems([0], toSection: .empty)
            dataSource?.apply(snapshot)
        } else {
            snapshot.deleteSections([.initial])
            snapshot.appendItems(bakeryList, toSection: .main)
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
            case .initial, .empty, .none:
                return self.normalSection()
            }
        }
        return layout
    }
    
    private func normalSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                       heightDimension: .fractionalHeight(1)), subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
}
