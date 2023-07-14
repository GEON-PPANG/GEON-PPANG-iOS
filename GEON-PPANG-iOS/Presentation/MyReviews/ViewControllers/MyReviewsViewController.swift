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
    private var myReviewslist: [BakeryListResponseDTO] = BakeryListResponseDTO.item
    
    // MARK: - UI Property
    
    private let naviView = CustomNavigationBar()
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: layout())
    
    // MARK: - Setting
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegistration()
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
            $0.addBackButtonAction(UIAction { _ in
                self.navigationController?.popToViewController(self, animated: true)
            })
            $0.configureLeftTitle(to: I18N.MyReviews.naviTitle)
        }
    }
    
    override func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setRegistration() {
        collectionView.register(cell: BakeryListCollectionViewCell.self)
        collectionView.register(header: MyReviewsHeaderView.self)
    }

    private func layout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .grouped)
        config.backgroundColor = .clear
        config.showsSeparators = true
        config.headerMode = .supplementary
        config.separatorConfiguration.topSeparatorVisibility = .hidden
        config.separatorConfiguration.bottomSeparatorVisibility = .visible

        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
}

// MARK: - UICollectionViewDataSource

extension MyReviewsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return myReviewslist.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BakeryListCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.getViewType(.reviewType)
        cell.updateUI(data: myReviewslist[indexPath.section], index: indexPath.item)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MyReviewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: MyReviewsHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, indexPath: indexPath)
            return header
    }
}
