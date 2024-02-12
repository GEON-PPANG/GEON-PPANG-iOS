//
//  FilterDiffableDataSource.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/08/17.
//

import UIKit

final class FilterDiffableDataSource: DiffableDataSourceProtocol {
    
    typealias Header = FilterCollectionViewHeader
    typealias Cell = FilterCollectionViewCell
    typealias SuppleRegistration = UICollectionView.SupplementaryRegistration
    typealias CellRegistration = UICollectionView.CellRegistration
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<FilterType, FilterCellModel.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<FilterType, FilterCellModel.ID>
    
    let headerKind = UICollectionView.elementKindSectionHeader
    
    // MARK: - Property
    
    var filterType: FilterType {
        didSet {
            self.configureCollectionView()
        }
    }
    
    // MARK: - UI Property
    
    var dataSource: DiffableDataSource!
    private let collectionView: UICollectionView
    
    // MARK: - Life Cycle
    
    init(_ collectionView: UICollectionView, _ type: FilterType) {
        self.collectionView = collectionView
        self.filterType = type
        
        setCollectionView()
        setDataSource()
        loadData()
    }
    
    // MARK: - Setting
    
    func setCollectionView() {
        
        collectionView.register(header: Header.self)
        collectionView.register(cell: Cell.self)
    }
    
    func setDataSource() {
        
        let cellRegistration = CellRegistration<FilterCollectionViewCell, FilterCellModel> { cell, _, filterModel in
            cell.filterType = self.filterType
            cell.typeLabelText = filterModel.title
            cell.descriptionLabelText = filterModel.subtitle
            cell.isSelected = filterModel.selected
        }
        
        let headerRegistration = SuppleRegistration<FilterCollectionViewHeader>(elementKind: headerKind) { header, _, _ in
            header.configureTitles(to: self.filterType)
        }
        
        dataSource = DiffableDataSource(collectionView: collectionView) { collectionView, indexPath, id -> UICollectionViewCell in
            let content = FilterCellModel.item(of: id)
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: content)
        }
        
        dataSource.supplementaryViewProvider = { collectionView, _, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration,
                                                                         for: indexPath)
        }
    }
    
}

extension FilterDiffableDataSource {
    
    func loadData() {
        
        var data: [FilterCellModel] = []
        switch filterType {
        case .purpose: data = FilterCellModel.purpose
        case .breadType: data = FilterCellModel.breadType
        case .ingredient: data = FilterCellModel.ingredient
        }
        let filterIDs = data.map { $0.id }
        var snapshot = Snapshot()
        snapshot.appendSections([filterType])
        snapshot.appendItems(filterIDs)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureLayout() {
        
        let layout = UICollectionViewFlowLayout()
        layout.do {
            $0.itemSize = filterType.cellSize
            $0.headerReferenceSize = filterType.headerSize
            $0.minimumLineSpacing = filterType.lineSpacing
            $0.sectionInset = .init(top: 32, left: 0, bottom: 0, right: 0)
        }
        self.collectionView.collectionViewLayout = layout
    }
    
    private func configureCollectionView() {
        
        loadData()
        configureLayout()
        
        collectionView.allowsMultipleSelection = filterType == .breadType ? true : false
    }
    
}
