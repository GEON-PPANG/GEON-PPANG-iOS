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

enum Item: Hashable {
    
    case bakery(HomeBestBakeryResponseDTO)
    case reviews(HomeBestReviewResponseDTO)
    case bottom

}

final class HomeViewController: BaseViewController {
    
    // MARK: - Property

    typealias DataSource = UICollectionViewDiffableDataSource<Sections, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Sections, Item>
    
    private var dataSource: DataSource?
    
    private var bakeryList: [HomeBestBakeryResponseDTO] = []
    private var reviewList: [HomeBestReviewResponseDTO] = []
    
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
        setSupplementaryView()
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
                Utils.push(self.navigationController, FilterPurposeViewController(maxSteps: 3, username: self.nickname))
            }
        }
        
        collectionView.do {
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .gbbBackground1
            $0.delegate = self
        }
    }
        
    private func setRegistration() {
        
        collectionView.registerCells(cells: [HomeBakeryCollectionViewCell.self,
                                             HomeReviewCollectionViewCell.self,
                                             HomeBottomCollectionViewCell.self])
        collectionView.register(header: HomeHeaderView.self)
    }
    
    private func setDataSource() {
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            
            switch item {
            case .bakery(let data):
                let cell: HomeBakeryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configureCellUI(data: data)
                return cell
            case .reviews(let data):
                let cell: HomeReviewCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configureCellUI(data: data)
                return cell
            case .bottom:
                let cell: HomeBottomCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                return cell
            }
        })
    }
    
    private func setSnapshot() {

        var snapshot = Snapshot()
        defer { dataSource?.apply(snapshot, animatingDifferences: false)}

        snapshot.appendSections(Sections.allCases)
        
        let itemsDictionary: [Sections: [Item]] = [
            .bakery: bakeryList.map { .bakery($0) },
            .review: reviewList.map { .reviews($0) },
            .bottom: [.bottom]
        ]

        for (section, items) in itemsDictionary {
            snapshot.appendItems(items, toSection: section)
        }

   }
    
    private func setSupplementaryView() {
        
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
    
    func layout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            switch sectionIndex {
            case 0:
                return self?.normalSection(headerSize: 49)
            case 1:
                return self?.normalSection(headerSize: 25)
            default:
                return self?.bottomSection()
            }
        })
    }
    
    private func normalSection(headerSize: CGFloat) -> NSCollectionLayoutSection {
        
        let itemGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(convertByWidthRatio(192)),
                                                   heightDimension: .estimated(convertByHeightRatio(236)))
        let item = NSCollectionLayoutItem(layoutSize: itemGroupSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemGroupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(headerSize))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        section.contentInsets = NSDirectionalEdgeInsets(top: 24,
                                                        leading: 24,
                                                        bottom: 30,
                                                        trailing: 24)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func bottomSection() -> NSCollectionLayoutSection {
        
        let itemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(convertByHeightRatio(115)))
        let item = NSCollectionLayoutItem(layoutSize: itemGroupSize)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemGroupSize,
                                                     subitem: item,
                                                     count: 1)
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let nextViewController = BakeryDetailViewController()
        
        let section = dataSource?.sectionIdentifier(for: indexPath.section)
        switch section {
        case .bakery:
            nextViewController.bakeryID = self.bakeryList[indexPath.item].bakeries.bakeryID
            Utils.push(self.navigationController, nextViewController)

        case .review:
            nextViewController.bakeryID = self.reviewList[indexPath.item].reviews.bakeryID
            Utils.push(self.navigationController, nextViewController)

        default:
            break
        }
        
    }
}

// MARK: - API

extension HomeViewController {
    
    private func getHomeBestData() {
        
        HomeAPI.shared.getBestBakery { response in
            guard let response = response else { return }
            guard let data = response.data else { return }
            let bakeryList = data.map { $0 }
            self.bakeryList = bakeryList
            self.setSnapshot()
        }
        
        HomeAPI.shared.getBestReviews { response in
            guard let response = response else { return }
            guard let data = response.data else { return }
            let reviewsList = data.map { $0 }
            self.reviewList = reviewsList
            self.setSnapshot()

        }
    }
}
