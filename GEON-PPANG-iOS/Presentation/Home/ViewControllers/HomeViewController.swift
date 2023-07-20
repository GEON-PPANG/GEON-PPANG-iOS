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
        case .bakery: return "바이블님 맞춤 BEST 건빵집"
        case .review: return "바이블님 맞춤 BEST 리뷰"
        case .bottom: return ""
        }
    }
}
final class HomeViewController: BaseViewController {
    
    // MARK: - Property
    
    typealias DataSource = UICollectionViewDiffableDataSource<Sections, AnyHashable>
    private var dataSource: DataSource?
    private var bakeryList: [BestBakery] = []
    private var reviewList: [BestReviews] = []
    
    lazy var safeArea = self.view.safeAreaLayoutGuide
    
    // MARK: - UI Property
    
    private let topView = HomeTopView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        requestHomeBestData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegistration()
        setDataSource()
        setReloadData()
    }
    
    override func setUI() {
        self.do {
            $0.view.backgroundColor = .white
        }
        
        topView.do {
            $0.setTitle("정둥어")
            $0.gotoNextView = {
                Utils.push(self.navigationController, SearchViewController())
            }
            $0.addActionToFilterButton {
                Utils.push(self.navigationController, FilterPurposeViewController(maxSteps: 3, username: "찐빵대빵"))
            }
        }
        
        collectionView.do {
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .white
            $0.bounces = false
            $0.delegate = self
        }
    }
    
    override func setLayout() {
        view.addSubviews(topView, collectionView)
        
        topView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(heightConsideringNotch(44))
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(200)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Setting
    
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
                cell.updateUI(data: item as! BestBakery)
                return cell
            case .review:
                let cell: HomeReviewCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.updateUI(data: item as! BestReviews)
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
                header.getSectionHeaderTitle(Sections.bakery.title)
            case 1:
                header.getSectionHeaderTitle(Sections.review.title)
            default:
                header.getSectionHeaderTitle(Sections.bottom.title)
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
}

// MARK: - API

extension HomeViewController {
    private func requestHomeBestData() {
        HomeAPI.shared.getBestBakery { response in
            guard let response = response else { return }
            guard let data = response.data else { return }
            self.bakeryList = []
            for item in data {
                self.bakeryList.append(item.convertToBestBakery())
            }
        }
        
        HomeAPI.shared.getBestReviews { response in
            guard let response = response else { return }
            guard let data = response.data else { return }
            self.reviewList = []
            for item in data {
                self.reviewList.append(item.convertToBakeryReviews())
            }
        }
    }
}
