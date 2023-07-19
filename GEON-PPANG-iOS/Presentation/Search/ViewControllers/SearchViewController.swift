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
    private var searchList: SearchResponseDTO?
    private var searchBakeryList: [SearchBakeryList] = []
    private var bakeryListCount: Int?
    private var currentSection: [Section] = [.initial]
    
    // MARK: - UI Property
    
    private let naviView = SearchNavigationView()
    private let searchResultView = SearchResultView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegistration()
        setDataSource()
        setReloadData()
    }
    
    // MARK: - Setting
    
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
            $0.textFieldClosure = { text in
                self.requestSearchBakery(bakeryID: text)
            }
        }
        searchResultView.do {
            $0.isHidden = true
        }
        collectionView.do {
            $0.isScrollEnabled = false
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
        }
    }
    
    private func setRegistration() {
        collectionView.register(cell: EmptyCollectionViewCell.self)
    }
    
    private func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<BakeryListCollectionViewCell, Item> { (cell, indexPath, item) in
            cell.separatorLayoutGuide.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            cell.getViewType(.defaultType)
            if let searchBakeryItem = item as? SearchBakeryList {
                cell.updateUI(data: searchBakeryItem, index: indexPath.item)
            }
        }
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
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
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
        })
    }
    
    private func setReloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        defer { dataSource?.apply(snapshot, animatingDifferences: false)}
        snapshot.appendSections([.initial])
        snapshot.appendItems([0])
    }
    
    private func updateDataSource(data: [SearchBakeryList]) {
        guard var snapshot = dataSource?.snapshot() else { return }
        if self.bakeryListCount == 0 {
            searchResultView.isHidden = false
            snapshot.deleteSections(currentSection)
            snapshot.appendSections([.empty])
            snapshot.appendItems([0], toSection: .empty)
            currentSection = [.empty]
            dataSource?.apply(snapshot)
        } else {
            searchResultView.isHidden = false
            snapshot.deleteSections(currentSection)
            snapshot.appendSections([.main])
            snapshot.appendItems(data, toSection: .main)
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
            case .initial, .empty, .none:
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
    
    func getListCount(_ count: Int) {
        if count == 0 {
            self.collectionView.isScrollEnabled = false
        } else {
            self.collectionView.isScrollEnabled = true
        }
    }
}

extension SearchViewController {
    func requestSearchBakery(bakeryID: String) {
        SearchAPI.shared.searchBakeryList(bakeryID: bakeryID) { response in
            guard let response = response else { return }
            guard let data = response.data else { return }
            self.searchBakeryList = []
            self.bakeryListCount = data.resultCount
            self.searchResultView.updateUI(count: data.resultCount)
            for item in data.bakeryList {
                self.searchBakeryList.append(item)
            }
            self.updateDataSource(data: self.searchBakeryList)
            self.getListCount(data.resultCount)
        }
    }
}
