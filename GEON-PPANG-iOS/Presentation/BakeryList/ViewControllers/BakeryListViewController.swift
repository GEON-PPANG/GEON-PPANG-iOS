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
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, BakeryCommonListResponseDTO>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, BakeryCommonListResponseDTO>
    
    private var dataSource: DataSource?
    private var bakeryList: [BakeryCommonListResponseDTO] = []
    private var sortBakeryBy: SortBakery = .byDefault
    
    private var sortBakeryName: String = SortBakery.byDefault.sortValue
    private var isFirstAppearance = false
    private var filterStatus: [Bool] = [false, false, false ]
    private var myFilterStatus: Bool = false
    private var pageNumber: Int = 1
    private var isLast: Bool = false
    private var requestBakeryList: BakeryRequestDTO { return BakeryRequestDTO(
        sortingOption: sortBakeryName,
        personalFilter: myFilterStatus,
        isHard: filterStatus[0],
        isDessert: filterStatus[1],
        isBrunch: filterStatus[2],
        pageNumber: pageNumber
    )}
    
    // MARK: - UI Property
    
    private let bakeryTopView = BakeryListTopView()
    private let bakeryFilterView = BakeryFilterView()
    private let bakerySortView = SortBakeryFilterView()
    private lazy var refreshControl = UIRefreshControl()
    private lazy var bubbleView = BubbleView(type: .left)
    private lazy var bakeryListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getUserFilterType()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDataSource()
        setSnapShot()
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        
        view.addSubview(bakeryTopView)
        bakeryTopView.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(68)
        }
        
        view.addSubview(bakeryFilterView)
        bakeryFilterView.snp.makeConstraints {
            $0.top.equalTo(bakeryTopView.snp.bottom)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(convertByHeightRatio(72))
        }
        
        view.addSubview(bakerySortView)
        bakerySortView.snp.makeConstraints {
            $0.top.equalTo(bakeryFilterView.snp.bottom)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(convertByHeightRatio(52))
        }
        
        view.addSubview(bakeryListCollectionView)
        bakeryListCollectionView.snp.makeConstraints {
            $0.top.equalTo(bakerySortView.snp.bottom)
            $0.leading.equalTo(safeArea)
            $0.trailing.equalTo(safeArea)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setUI() {
        
        bakeryTopView.do {
            $0.addActionToSearchButton {
                let searchViewController = SearchViewController()
                searchViewController.viewType = .LIST
                
                Utils.push(self.navigationController, searchViewController)
                AnalyticManager.log(event: .list(.clickSearchList))
            }
        }
        
        bakeryFilterView.do {
            $0.applyAction {
                if KeychainService.readKeychain(of: .role) == UserRole.visitor.rawValue {
                    Utils.showLoginRequiredSheet(on: self, type: .recommendation)
                } else {
                    Utils.push(self.navigationController, FilterViewController(from: .list))
                }
                
                AnalyticManager.log(event: .list(.startFilterList))
            }
            $0.filterData = { [weak self] data in
                guard let self else { return }
                
                for (index, value) in data.enumerated() {
                    self.filterStatus[index] = value
                }
                getDefaultBakeryList()
            }
        }
        
        bakerySortView.do {
            $0.backgroundColor = .gbbBackground1
            $0.applyFilterAction {
                self.bakeryFilterButtonTapped()
            }
            $0.tappedCheckBox = { [weak self] tapped in
                guard let self else { return }
                self.myFilterStatus = !tapped
                getDefaultBakeryList()
                self.bakerySortView.configureCheckBox()
                
                if !self.myFilterStatus {
                    AnalyticManager.log(event: .list(.clickFilterOff))
                }
            }
        }
        
        refreshControl.do {
            $0.addAction(UIAction { [weak self] _ in
                self?.loadData()
            }, for: .valueChanged)
        }
        
        bakeryListCollectionView.do {
            $0.delegate = self
            $0.refreshControl = refreshControl
        }
    }
    
    private func configureBubbleView(_ isAppeared: Bool) {
        
        if isAppeared {
            bubbleView.removeFromSuperview()
        } else {
            view.addSubview(bubbleView)
            bubbleView.configureLayout(trailing: safeArea, top: bakeryFilterView.snp.bottom, offset: -11)
        }
    }
    
    private func layout() -> UICollectionViewLayout {
        
        let listConfig = LayoutUtils.listConfiguration(appearance: .plain,
                                                       headerMode: .none) { indexPath, config in
            var config = config
            guard let itemCount = self.dataSource?.snapshot().itemIdentifiers(inSection: .main).count else { return config }
            let isLastItem = indexPath.item == itemCount - 1
            config.bottomSeparatorVisibility = isLastItem ? .hidden : .visible
            return config
        }
        
        let layout = UICollectionViewCompositionalLayout.list(using: listConfig)
        return layout
    }
    
    private func setDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<BakeryCommonCollectionViewCell, BakeryCommonListResponseDTO> { (cell, _, item) in
            cell.configureCellUI(data: item)
        }
        
        dataSource = DataSource(collectionView: bakeryListCollectionView) { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath,
                                                                item: itemIdentifier)
        }
    }
    
    private func setSnapShot() {
        
        var snapshot = SnapShot()
        defer { self.dataSource?.applySnapshotUsingReloadData(snapshot)}
        
        snapshot.appendSections([.main])
        snapshot.appendItems(bakeryList)
    }
    
    // MARK: - Custom Method
    
    private func configureFilterButtonText() {
        
        switch sortBakeryBy {
        case .byDefault:
            bakerySortView.configureFilterButtonText(to: "기본순")
        case .byReviews: bakerySortView.configureFilterButtonText(to: "리뷰 많은순")
        }
    }
    
    private func bakeryFilterButtonTapped() {
        
        let sortBottomSheet = SortBottomSheetViewController(sort: sortBakeryBy)
        sortBottomSheet.modalPresentationStyle = .overFullScreen
        sortBottomSheet.dataBind = { sortBy in
            self.sortBakeryBy = sortBy
            self.configureFilterButtonText()
            self.sortBakeryName = sortBy.sortValue
            self.getDefaultBakeryList()
        }
        self.present(sortBottomSheet, animated: false)
    }
    
    private func loadData() {
        
        getDefaultBakeryList()
        refreshControl.endRefreshing()
    }
    
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -bakeryListCollectionView.contentInset.top)
        bakeryListCollectionView.setContentOffset(desiredOffset, animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension BakeryListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let nextViewController = BakeryDetailViewController()
        nextViewController.bakeryID = self.bakeryList[indexPath.item].bakeryID
        Utils.setDetailSourceType(.LIST)
        Utils.push(self.navigationController, nextViewController)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item == bakeryList.count - 1, !self.isLast {
            getMoreBakeryList()
        }
    }
}

// MARK: - Network

extension BakeryListViewController {
    
    private func makeRequestBakeryList(pageNumber: Int) -> BakeryRequestDTO {
        return BakeryRequestDTO(
            sortingOption: sortBakeryName,
            personalFilter: myFilterStatus,
            isHard: filterStatus[0],
            isDessert: filterStatus[1],
            isBrunch: filterStatus[2],
            pageNumber: pageNumber
        )
    }
    
    private func getBakeryList(pageNumber: Int) {
        self.pageNumber = pageNumber
        let requestBakeryList = makeRequestBakeryList(pageNumber: pageNumber)
        self.getBakeryList(request: requestBakeryList)
    }
    
    private func getDefaultBakeryList() {
        scrollToTop()
        self.bakeryList = []
        getBakeryList(pageNumber: 1)
    }
    
    private func getMoreBakeryList() {
        getBakeryList(pageNumber: pageNumber)
    }
    
    private func getBakeryList(request: BakeryRequestDTO) {
        BakeriesAPI.shared.getBakeries(parameters: request) { response in
            guard let response = response else { return }
            guard let data = response.data else { return }
            
            self.bakeryList.append(contentsOf: data.content)
            self.isLast = data.last
            self.pageNumber += data.last ? 0 : 1
            
            self.setSnapShot()
        }
    }
    
    private func getUserFilterType() {
        guard KeychainService.readKeychain(of: .role) == UserRole.member.rawValue
        else { return }
        
        MemberAPI.shared.getFilter { response in
            guard let response = response else { return }
            guard let data = response.data else { return }
            if !data.mainPurpose.contains("NONE") {
                self.bakerySortView.tappedButton(true)
                self.myFilterStatus = true
                self.configureBubbleView(true)
            } else {
                self.bakerySortView.tappedButton(false)
                if !self.isFirstAppearance {
                    self.configureBubbleView(false)
                    self.isFirstAppearance = true
                }
            }
            
            self.getDefaultBakeryList()
        }
    }
}
