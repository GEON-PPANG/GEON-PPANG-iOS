//
//  BakeryFilterView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class BakeryFilterView: UIView {
    
    // MARK: - Property
    
    enum Section: Hashable {
        case main
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, BakeryFilterItems>
    private var dataSource: DataSource?
    private var filterlist: [BakeryFilterItems] = BakeryFilterItems.item
    private var filterStatus: [Bool] = [false, false, false]
    var filterData: (([Bool]) -> Void)?
    
    // MARK: - UI Property
    
    private lazy var filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    private lazy var filterButton = UIButton()
    
    private let topView = LineView()
    private let lineView = LineView()
    private let bottomView = LineView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
        
        setRegistration()
        setDataSource()
        setReloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.addSubview(topView)
        topView.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        self.addSubview(filterButton)
        filterButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        
        self.addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.trailing.equalTo(filterButton.snp.leading).offset(-18)
            $0.directionalVerticalEdges.equalToSuperview().inset(15)
        }
        self.addSubview(filterCollectionView)
        filterCollectionView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(lineView.snp.leading).offset(-20)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        self.addSubview(bottomView)
        bottomView.snp.makeConstraints {
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    private func setUI() {
        
        filterCollectionView.do {
            $0.delegate = self
            $0.showsHorizontalScrollIndicator = false
        }
        
        filterButton.do {
            $0.setImage(.bakeryFilterButton, for: .normal)
        }
    }
    
    func layout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 24, bottom: 0, right: 0)
        return layout
    }
    
    private func setRegistration() {
        
        filterCollectionView.register(cell: BakeryFilterCollectionViewCell.self)
    }
    
    private func setDataSource() {
        
        dataSource = DataSource(collectionView: filterCollectionView, cellProvider: { collectionView, indexPath, item in
            let cell: BakeryFilterCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configureFilterUI(item: item, index: indexPath.item)
            return cell
        })
    }
    
    private func setReloadData() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, BakeryFilterItems>()
        defer { dataSource?.apply(snapshot, animatingDifferences: false)}
        snapshot.appendSections([.main])
        snapshot.appendItems(filterlist)
    }
    
    // MARK: - Custom Method
    
    func applyAction(_ action: @escaping () -> Void) {
        
        let action = UIAction { _ in
            action()
        }
        filterButton.addAction(action, for: .touchUpInside)
    }
}

// MARK: - UICollectionViewDelegate

extension BakeryFilterView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.filterlist[indexPath.item].status == .off {
            self.filterlist[indexPath.item].status = .on
        } else {
            self.filterlist[indexPath.item].status = .off
        }
        
        self.filterlist[indexPath.item] = self.filterlist[indexPath.item].isSelected()
        
        switch self.filterlist[indexPath.item].filter {
        case .HARD:
            filterStatus[0] = (self.filterlist[indexPath.item].status == .on)
        case .DESSERT:
            filterStatus[1] = (self.filterlist[indexPath.item].status == .on)
        case .BRUNCH:
            filterStatus[2] = (self.filterlist[indexPath.item].status == .on)
        }
        self.filterData?(self.filterStatus)
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, BakeryFilterItems>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filterlist)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BakeryFilterView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth: CGFloat
        let cell: BakeryFilterCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.filterTitle.text = filterlist[indexPath.row].filter.title
        cell.configureFilterSize()
        cellWidth = cell.filterTitle.frame.width + 48
        
        return CGSize(width: cellWidth, height: 36)
    }
}
