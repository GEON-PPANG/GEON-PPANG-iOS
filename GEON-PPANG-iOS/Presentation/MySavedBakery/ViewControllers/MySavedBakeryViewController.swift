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
        case main
    }
    typealias DataSource = UICollectionViewDiffableDataSource<Section, BakeryListResponseDTO>
    private var dataSource: DataSource?
    private var filterlist: [BakeryListResponseDTO] = BakeryListResponseDTO.item
    
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    // MARK: - UI Property
    
    private let naviView = CustomNavigationBar()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setRegistration()
        setupDataSource()
        setReloadData()
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        view.addSubviews(naviView, collectionView)
        
        naviView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalTo(safeArea)
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
                self.navigationController?.popToViewController(self, animated: true)
            })
            $0.configureLeftTitle(to: I18N.MySavedBakery.naviTitle)
        }
    }
    
    private func setRegistration() {
        collectionView.register(cell: BakeryListCollectionViewCell.self)
    }
    
    private func layout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.backgroundColor = .clear
        config.showsSeparators = true
        
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func setupDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let cell: BakeryListCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.getViewType(.defaultType)
            if let bakeryListItem = item as? BakeryListResponseDTO {
                let bakeryListProtocols = BakeryListProtocols(
                    bakeryName: bakeryListItem.bakeryName,
                    bookmarkCount: bakeryListItem.bookmarkCount,
                    isBooked: bakeryListItem.isBooked,
                    isHACCP: bakeryListItem.isHACCP,
                    isVegan: bakeryListItem.isVegan,
                    isNonGMO: bakeryListItem.isNonGMO,
                    firstNearStation: bakeryListItem.firstNearStation,
                    secondNearStation: bakeryListItem.secondNearStation ?? "",
                    breadType: bakeryListItem.breadType
                )
                cell.updateUI(data: bakeryListProtocols, index: indexPath.item)
            }
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
