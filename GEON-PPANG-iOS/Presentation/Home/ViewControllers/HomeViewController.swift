//
//  HomeViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/08.
//

import UIKit

import Then
import SnapKit

enum Sections: Int, Hashable, CaseIterable {
    case bakery, review, bottom
    
    var title: String {
        switch self {
        case .bakery: return "님 맞춤 BEST 건빵집"
        case .review: return "님 맞춤 BEST 리뷰"
        case .bottom: return ""
        }
    }
}
final class HomeViewController: BaseViewController {
    
    // MARK: - Property
    
    typealias DataSource = UICollectionViewDiffableDataSource<Sections, AnyHashable>
    private var dataSource: DataSource?
    
    private var bakeryList: [BestBakery] = [] {
        didSet {
            self.setReloadData()
        }
    }

    private var reviewList: [BestReviews] = [] {
        didSet {
            self.setReloadData()
        }
    }
    
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    private var nickname =  UserDefaults.standard.string(forKey: "nickname") ?? ""
    
    // MARK: - UI Property
    
    private let topView = HomeTopView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getHomeBestData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegistration()
        setDataSource()
        setReloadData()
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        
        view.addSubview(topView)
        topView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(heightConsideringNotch(44))
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(200)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setUI() {
        
        self.do {
            $0.view.backgroundColor = .white
        }
        
        topView.do {
            $0.configureTitleText(nickname)
            $0.pushToSearchView = {
                Utils.push(self.navigationController, SearchViewController())
            }
            $0.addActionToFilterButton {
                Utils.push(self.navigationController, FilterViewController(isInitial: false))
            }
        }
        
        collectionView.do {
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .white
            $0.bounces = false
            $0.delegate = self
        }
    }
        
    private func setRegistration() {
        
        collectionView.register(cell: HomeBakeryCollectionViewCell.self)
        collectionView.register(cell: HomeReviewCollectionViewCell.self)
        collectionView.register(cell: HomeBottomCollectionViewCell.self)
        collectionView.register(header: HomeHeaderView.self)
    }
    
    private func setDataSource() {
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let section = self.dataSource?.snapshot().sectionIdentifiers[indexPath.section]
            switch section {
            case .bakery:
                let cell: HomeBakeryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configureCellUI(data: item as! BestBakery)
                return cell
            case .review:
                let cell: HomeReviewCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configureCellUI(data: item as! BestReviews)
                return cell
            case .bottom, .none:
                let cell: HomeBottomCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                return cell
            }
        })
    }
    
    private func setReloadData() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Sections, AnyHashable>()
        defer { dataSource?.apply(snapshot, animatingDifferences: false)}
        
        snapshot.appendSections([.bakery, .review, .bottom])
        
        let itemsDictionary: [Sections: [AnyHashable]] = [
            .bakery: bakeryList,
            .review: reviewList,
            .bottom: [0]
        ]
        
        for (section, items) in itemsDictionary {
            snapshot.appendItems(items, toSection: section)
        }
        
        dataSource?.supplementaryViewProvider = { (collectionView, _, indexPath) in
            let header: HomeHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, indexPath: indexPath)
            
            switch indexPath.section {
            case 0:
                header.configureSectionHeaderTitle(self.nickname + Sections.bakery.title)
            case 1:
                header.configureSectionHeaderTitle(self.nickname + Sections.review.title)
            default:
                header.configureSectionHeaderTitle(self.nickname + Sections.bottom.title)
            }
            return header
        }
        
    }
    
    func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            let section = Sections(rawValue: sectionIndex)!
            switch section {
            case .bakery:
                return self.normalSection(headerSize: 49)
            case .review:
                return self.normalSection(headerSize: 25)
            case .bottom:
                return self.bottomSection()
            }
        }
        return layout
    }
    
    private func normalSection(headerSize: CGFloat) -> NSCollectionLayoutSection {
        let itemGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(convertByWidthRatio(192)),
                                                   heightDimension: .estimated(convertByHeightRatio(236)))
        let item = NSCollectionLayoutItem(layoutSize: itemGroupSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemGroupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(headerSize))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 24, bottom: 30, trailing: 24)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func bottomSection() -> NSCollectionLayoutSection {
        let itemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(convertByHeightRatio(115)))
        let item = NSCollectionLayoutItem(layoutSize: itemGroupSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemGroupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextViewController = BakeryDetailViewController()
        let section = Sections(rawValue: indexPath.section)!
        switch section {
        case .bakery:
            nextViewController.bakeryID = self.bakeryList[indexPath.item].bakeryID
        case .review:
            nextViewController.bakeryID = self.reviewList[indexPath.item].bakeryID
        case .bottom:
            return
        }
        Utils.push(self.navigationController, nextViewController)
    }
}

// MARK: - API

extension HomeViewController {
    private func getHomeBestData() {
        HomeAPI.shared.getBestBakery { response in
            guard let response = response else { return }
            guard let data = response.data else { return }
            var bakeryList: [BestBakery] = []
            
            for item in data {
                bakeryList.append(item.convertToBestBakery())
            }
            self.bakeryList = bakeryList
        }
        
        HomeAPI.shared.getBestReviews { response in
            guard let response = response else { return }
            guard let data = response.data else { return }
            var reviewsList: [BestReviews] = []
            for item in data {
                reviewsList.append(item.convertToBakeryReviews())
            }
            self.reviewList = reviewsList
        }
    }
}
