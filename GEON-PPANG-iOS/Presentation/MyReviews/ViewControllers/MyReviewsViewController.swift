//
//  MyReviewsViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MyReviewsViewController: BaseViewController {
    
    // MARK: - Property
    
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    private var myReviewslist: [MyReviewsResponseDTO] = []
    
    // MARK: - UI Property
    
    private let naviView = CustomNavigationBar()
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: layout())
    
    // MARK: - Setting
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegistration()
        getSavedBakeryList()
    }
    
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
            $0.configureBottomLine()
            $0.configureBackButtonAction(UIAction { _ in
                self.navigationController?.popViewController(animated: true)
            })
            $0.configureLeftTitle(to: I18N.MyReviews.naviTitle)
        }
        
        collectionView.do {
            $0.isScrollEnabled = false
            $0.contentInset = .init(top: 18, left: 0, bottom: 0, right: 0)
        }
    }
    
    override func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setRegistration() {
        collectionView.register(cell: MyReviewsCollectionViewCell.self)
        collectionView.register(cell: EmptyCollectionViewCell.self)
        collectionView.register(header: MyReviewsHeaderView.self)
        
    }
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {_, layoutEnvirnment  in
            if self.myReviewslist.isEmpty {
                return self.normalSection()
            } else {
                var config = UICollectionLayoutListConfiguration(appearance: .grouped)
                config.backgroundColor = .clear
                config.showsSeparators = true
                config.headerMode = .supplementary
                config.separatorConfiguration.topSeparatorVisibility = .hidden
                config.separatorConfiguration.bottomSeparatorVisibility = .visible
                
                let layoutSection = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvirnment)
                return layoutSection
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
    
    func getListCount(_ count: Int) {
        if count == 0 {
            self.collectionView.isScrollEnabled = false
        } else {
            self.collectionView.isScrollEnabled = true
        }
    }
}

// MARK: - UICollectionViewDataSource

extension MyReviewsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if myReviewslist.isEmpty {
            return 1
        } else {
            return myReviewslist.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if myReviewslist.isEmpty {
            let cell: EmptyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.getViewType(.noReview)
            cell.getEmtyText("내가 쓴 리뷰가 없어요!")
            return cell
        } else {
            let cell: MyReviewsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.updateUI(myReviewslist[indexPath.section])
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MyReviewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if myReviewslist.isEmpty {
            return UICollectionReusableView()
        } else {
            let header: MyReviewsHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, indexPath: indexPath)
            header.getReviewDate(self.myReviewslist[indexPath.item].createdAt)
            return header
        }
    }
}

// MARK: - API

extension MyReviewsViewController {
    private func getSavedBakeryList() {
        MyPageAPI.shared.getMyReviews { response in
            guard let response = response else { return }
            guard let data = response.data else { return }
            for item in data {
                self.myReviewslist.append(item)
            }
            self.collectionView.reloadData()
            self.getListCount(self.myReviewslist.count)
        }
    }
}
