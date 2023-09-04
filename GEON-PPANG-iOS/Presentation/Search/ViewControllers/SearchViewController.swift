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
    typealias Item = AnyHashable
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    private var dataSource: DataSource?
    private var searchBakeryList: [BakeryCommonListResponseDTO] = []
    private var currentSection: [Section] = [.initial]
    
    private var bakeryName: String?
    private var bakeryListCount: Int?
    
    // MARK: - UI Property
    
    private let naviView = SearchNavigationView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let bakeryName = self.bakeryName {
            getSearchBakery(bakeryName: bakeryName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegistration()
        setDataSource()
        setSnapshot()
        setSupplementView()
    }
    
    // MARK: - Setting
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    override func setLayout() {
        
        view.addSubview(naviView)
        naviView.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(convertByHeightRatio(68))
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setUI() {
        
        naviView.do {
            $0.dismissSearchView = {
                self.navigationController?.popViewController(animated: true)
            }
            $0.fetchBakeryList = { text in
                self.bakeryName = text
                self.getSearchBakery(bakeryName: text)
            }
        }
        
        collectionView.do {
            $0.isScrollEnabled = false
            $0.backgroundColor = .gbbBackground1
            $0.showsHorizontalScrollIndicator = false
            $0.delegate = self
        }
    }
    
    private func setRegistration() {
        
        collectionView.register(cell: EmptyCollectionViewCell.self)
        collectionView.register(header: SearchResultHeaderView.self)
    }
    
    private func setDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<BakeryCommonCollectionViewCell, Item> { (cell, _, item) in
            
            if let searchBakeryItem = item as? BakeryCommonListResponseDTO {
                cell.configureCellUI(data: searchBakeryItem)
            }
        }
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let section = self.dataSource?.snapshot().sectionIdentifiers[indexPath.section]
            switch section {
            case .initial:
                let cell: EmptyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configureViewType(.initialize)
                return cell
            case .empty:
                let cell: EmptyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configureViewType(.noSearch)
                return cell
            case .main, .none:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
        })
    }
    
    private func setSnapshot() {
        
        var snapshot = Snapshot()
        defer { dataSource?.apply(snapshot, animatingDifferences: false)}
        snapshot.appendSections([.initial])
        snapshot.appendItems([0])
    }
    
    private func setSupplementView() {
        dataSource?.supplementaryViewProvider = {[weak self] collectionView, kind, indexPath -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchResultHeaderView.identifier, for: indexPath)
            
            let section = self?.dataSource?.sectionIdentifier(for: indexPath.section)
            switch section {
            case .empty, .main:
    
                (header as? SearchResultHeaderView)?.configureUI(count: self?.bakeryListCount ?? 0)
            default:
                break
            }
            return header
        }
    }
    
    private func configureDataSource(data: [BakeryCommonListResponseDTO]) {
        
        guard var snapshot = dataSource?.snapshot() else { return }
        
        if self.bakeryListCount == 0 {
            snapshot.deleteSections(currentSection)
            snapshot.appendSections([.empty])
            snapshot.appendItems([0], toSection: .empty)
            currentSection = [.empty]
            dataSource?.apply(snapshot)
        } else {
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
                config.backgroundColor = .gbbBackground1
                config.headerMode = .supplementary
                config.headerTopPadding = 0
                config.separatorConfiguration.topSeparatorVisibility = .hidden
                
                config.itemSeparatorHandler = { indexPath, config in
                    var config = config
                    guard let itemCount = self.dataSource?.snapshot().itemIdentifiers(inSection: .main).count else { return config }
                    
                    let isLastItem = indexPath.item == itemCount - 1
                    config.bottomSeparatorVisibility = isLastItem ? .hidden : .visible
                    return config
                }
                
                let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvirnment)
                section.boundarySupplementaryItems = [LayoutUtils.header(55)]
                
                return section
                
            case .empty:
                return LayoutUtils.section(true, 55)
            case .initial, .none:
                return LayoutUtils.section(false)
            }
        }
        return layout
    }
    
    func configureisScrollable(_ count: Int) {
        if count == 0 {
            self.collectionView.isScrollEnabled = false
        } else {
            self.collectionView.isScrollEnabled = true
        }
    }
}

// MARK: - UICollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let nextViewController = BakeryDetailViewController()
        let section = dataSource?.sectionIdentifier(for: indexPath.section)
        switch section {
        case .empty, .initial, .none: break
        case .main:
            nextViewController.bakeryID = self.searchBakeryList[indexPath.item].bakeryID
            Utils.push(self.navigationController, nextViewController)
        }
    }
}

// MARK: - API

extension SearchViewController {
    func getSearchBakery(bakeryName: String) {
        
        SearchAPI.shared.searchBakeryList(bakeryName: bakeryName) { response in
            guard let response = response else { return }
            guard let data = response.data else { return }
            self.bakeryListCount = data.resultCount
            let searchList = data.bakeryList.map { $0 }
            self.searchBakeryList = searchList
            self.configureDataSource(data: searchList)
            self.configureisScrollable(data.resultCount)
        }
    }
}
