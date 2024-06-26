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
    typealias SanpShot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
    
    private var dataSource: DataSource?
    private var savedList: [BookmarkBakeryListResponseDTO] = []
    private var currentSection: [Section] = [.empty]
    
    // MARK: - UI Property
    
    private let naviView = CustomNavigationBar()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    private lazy var refreshControl = UIRefreshControl()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getSavedBakeryList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegistration()
        setDataSource()
        setReloadData()
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        
        view.addSubview(naviView)
        naviView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalTo(safeArea)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(safeArea)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setUI() {
        
        naviView.do {
            $0.configureBackButtonAction(UIAction { _ in
                dump(self.navigationController)
                self.navigationController?.popViewController(animated: true)
            })
            $0.configureBottomLine()
            $0.configureCenterTitle(to: I18N.MySavedBakery.naviTitle, with: .title2!)
        }
        
        refreshControl.do {
            $0.addAction(UIAction { [weak self] _ in
                self?.loadData()
            }, for: .valueChanged)
        }
        
        collectionView.do {
            $0.backgroundColor = .gbbBackground1
            $0.delegate = self
            $0.refreshControl = refreshControl
        }
    }
    
    private func setRegistration() {
        
        collectionView.register(cell: EmptyCollectionViewCell.self)
    }
    
    private func setDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<BakeryCommonCollectionViewCell, BookmarkBakeryListResponseDTO> { (cell, _, item) in
            cell.configureCellUI(data: item)
        }
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let section = self.dataSource?.snapshot().sectionIdentifiers[indexPath.section]
            switch section {
            case .main:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item as? BookmarkBakeryListResponseDTO)
            case .empty, .none:
                let cell: EmptyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configureViewType(.noBookmark)
                return cell
            }
        })
    }
    
    private func setReloadData() {
        
        var snapshot = SanpShot()
        defer { dataSource?.apply(snapshot, animatingDifferences: false)}
        
        snapshot.appendSections([.empty])
        snapshot.appendItems([0])
    }
    
    private func configureDataSource(data: [BookmarkBakeryListResponseDTO]) {
        
        guard var snapshot = dataSource?.snapshot() else { return }
        
        if data.count == 0 {
            snapshot.deleteSections(currentSection)
            snapshot.appendSections([.empty])
            snapshot.appendItems([0], toSection: .empty)
            currentSection = [.empty]
            dataSource?.apply(snapshot)
        } else {
            snapshot.deleteSections(currentSection)
            snapshot.appendSections([.main])
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
                let config = LayoutUtils.listConfiguration(appearance: .plain,
                                                           headerMode: .none) { indexPath, config in
                    var config = config
                    guard let itemCount = self.dataSource?.snapshot().itemIdentifiers(inSection: .main).count else { return config }
                    
                    let isLastItem = indexPath.item == itemCount - 1
                    config.bottomSeparatorVisibility = isLastItem ? .hidden : .visible
                    return config
                }
                let layoutSection = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvirnment)
                return layoutSection
            case .empty, .none:
                return LayoutUtils.emptySection(hasHeader: false)
            }
        }
        
        return layout
    }
    
    func configureScollable(_ count: Int) {
        
        if count == 0 {
            collectionView.isScrollEnabled = false
        } else {
            collectionView.isScrollEnabled = true
        }
    }
}

extension MySavedBakeryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !self.savedList.isEmpty {
            let nextViewController = BakeryDetailViewController()
            nextViewController.bakeryID = self.savedList[indexPath.item].bakeryID
            Utils.push(self.navigationController, nextViewController)
            Utils.setDetailSourceType(.MYPAGE_MYSTORE)
        }
    }
}

extension MySavedBakeryViewController {
    
    private func loadData() {
        
        getSavedBakeryList()
        refreshControl.endRefreshing()
    }
    
    private func getSavedBakeryList() {
        MemberAPI.shared.bookmarks { response in
            guard let response = response else { return }
            guard let data = response.data else { return }
            let savedList = data.map { $0 }
            self.savedList = savedList
            self.configureDataSource(data: self.savedList)
            self.configureScollable(data.count)
        }
    }
}
