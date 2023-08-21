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
    private var dataSource: DataSource?
    private var savedList: [BakeryList] = []
    private var currentSection: [Section] = [.empty]
    
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    // MARK: - UI Property
    
    private let naviView = CustomNavigationBar()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
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
            $0.configureCenterTitle(to: I18N.MySavedBakery.naviTitle)
        }
        
        collectionView.do {
            $0.delegate = self
        }
    }
    
    private func setRegistration() {
        
        collectionView.register(cell: BakeryCollectionViewListCell.self)
        collectionView.register(cell: EmptyCollectionViewCell.self)
    }
    
    private func setDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<BakeryCollectionViewListCell, BakeryList> { (cell, _, item) in
            cell.separatorLayoutGuide.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            if let bakeryListItem = item as? BakeryList {
                cell.configureCellUI(data: bakeryListItem)
            }
        }
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let section = self.dataSource?.snapshot().sectionIdentifiers[indexPath.section]
            switch section {
            case .main:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item as? BakeryList)
            case .empty, .none:
                let cell: EmptyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configureViewType(.noBookmark)
                return cell
            }
        })
    }
    
    private func setReloadData() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        defer { dataSource?.apply(snapshot, animatingDifferences: false)}
        snapshot.appendSections([.empty])
        snapshot.appendItems([0])
    }
    
    private func configureDataSource(data: [BakeryList]) {
        
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
                var config = UICollectionLayoutListConfiguration(appearance: .plain)
                config.backgroundColor = .clear
                config.showsSeparators = true
                
                let layoutSection = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvirnment)
                return layoutSection
            case .empty, .none:
                return self.normalSection()
            }
        }
        
        return layout
    }
    
    private func normalSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(convertByHeightRatio(694) / convertByHeightRatio(812))
        ))
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(convertByHeightRatio(694) / convertByHeightRatio(812))
            ),
            subitem: item,
            count: 1
        )
        let section = NSCollectionLayoutSection(group: group)
        
        return section
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
        let nextViewController = BakeryDetailViewController()
        nextViewController.bakeryID = self.savedList[indexPath.item].bakeryID
        Utils.push(self.navigationController, nextViewController)
    }
}

extension MySavedBakeryViewController {
    
    private func getSavedBakeryList() {
        MyPageAPI.shared.getBookmarks { response in
            guard let response = response else { return }
            guard let data = response.data else { return }
            self.savedList = []
            for item in data {
                self.savedList.append(item.convertToBakeryList())
            }
            self.configureDataSource(data: self.savedList)
            self.configureScollable(data.count)
        }
    }
}
