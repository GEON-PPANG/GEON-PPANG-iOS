//
//  FilterDiffableDataSource.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/08/17.
//

import UIKit

final class FilterDiffableDataSource {
    
    typealias CollectionViewHeader = FilterCollectionViewHeader
    typealias CollectionViewCell = FilterCollectionViewCell
    typealias DiffableDataSource = UICollectionViewDiffableDataSource
    typealias Snapshot = NSDiffableDataSourceSnapshot<FilterType, FilterCellModel.ID>
    
    let headerKind = UICollectionView.elementKindSectionHeader
    
    // MARK: - Property
    
    var filterType: FilterType {
        didSet {
            self.configureData()
            self.configureLayout()
        }
    }
    
    // MARK: - UI Property
    
    var dataSource: DiffableDataSource<FilterType, FilterCellModel.ID>!
    private let collectionView: UICollectionView
    
    // MARK: - Life Cycle
    
    init(_ collectionView: UICollectionView, _ type: FilterType) {
        self.collectionView = collectionView
        self.filterType = type
        
        setCollectionView()
        setDataSource()
        configureData()
    }
    
    // MARK: - Setting
    
    private func setCollectionView() {
        
        collectionView.register(header: CollectionViewHeader.self)
        collectionView.register(cell: CollectionViewCell.self)
    }
    
    private func setDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<FilterCollectionViewCell, FilterCellModel> { cell, _, filterModel in
            cell.filterType = self.filterType
            cell.typeLabelText = filterModel.title
            if let subtitle = filterModel.subtitle {
                cell.descriptionLabelText = subtitle
            }
            cell.isSelected = filterModel.selected
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<FilterCollectionViewHeader>(elementKind: headerKind) { header, _, _ in
            header.configureTitles(to: self.filterType)
        }
        
        dataSource = DiffableDataSource(collectionView: collectionView) { collectionView, indexPath, id -> UICollectionViewCell in
            let content = FilterCellModel.contents(of: self.filterType).first { $0.id == id }
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath,
                                                                item: content)
        }
        
        dataSource.supplementaryViewProvider = { collectionView, _, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration,
                                                                         for: indexPath)
        }
    }
    
    // MARK: - Custom Method
    
    func configureData() {
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
    
}
