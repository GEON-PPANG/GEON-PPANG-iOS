//
//  BakeryListViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/08.
//

import UIKit

import SnapKit
import Then

final class BakeryListViewController: BaseViewController {
    
    // MARK: - Property
    
    enum Section {
        case main
    }
    typealias DataSource = UICollectionViewDiffableDataSource<Section, BakeryListResponseDTO>
    private var dataSource: DataSource?
    private var filterlist: [BakeryListResponseDTO] = BakeryListResponseDTO.item
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    // MARK: - UI Property
    
    private let bakeryTopView = BakeryListTopView()
    private let bakeryFilterView = BakeryFilterView()
    private lazy var bakeryListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegistration()
        setupDataSource()
        setReloadData()
        
    }
    
    override func setUI() {
        bakeryFilterView.do {
            $0.backgroundColor = .clear
        }
    }
    
    override func setLayout() {
        view.addSubviews(bakeryTopView, bakeryFilterView, bakeryListCollectionView)
        
        bakeryTopView.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(91)
        }
        
        bakeryFilterView.snp.makeConstraints {
            $0.top.equalTo(bakeryTopView.snp.bottom)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(convertByHeightRatio(72))
        }
        
        bakeryListCollectionView.snp.makeConstraints {
            $0.top.equalTo(bakeryFilterView.snp.bottom)
            $0.leading.equalTo(safeArea).offset(-24)
            $0.trailing.equalTo(safeArea)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setRegistration() {
        bakeryListCollectionView.register(cell: BakeryListCollectionViewCell.self)
    }
    
    private func layout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.backgroundColor = .clear
        config.showsSeparators = true
        
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func setupDataSource() {
        dataSource = DataSource(collectionView: bakeryListCollectionView, cellProvider: { collectionView, indexPath, item in
            let cell: BakeryListCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.getViewType(.defaultType)
            cell.updateUI(data: item, index: indexPath.item)
            return cell
        })
    }
    
    private func setReloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BakeryListResponseDTO>()
        defer { dataSource?.apply(snapshot, animatingDifferences: false)}
        snapshot.appendSections([.main])
        snapshot.appendItems(filterlist)
    }
}
