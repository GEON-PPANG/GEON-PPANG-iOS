//
//  BakeryDetailViewController.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/13.
//

import UIKit

import SnapKit
import Then

final class BakeryDetailViewController: BaseViewController {
    
    // MARK: - Property
    
    private var overviewData: BakeryDetailResponseDTO = BakeryDetailResponseDTO(bakeryID: 0, bakeryName: "", bakeryPicture: "", isHACCP: false, isVegan: false, isNonGMO: false, firstNearStation: "", secondNearStation: "", isBookMarked: false, bookMarkCount: 0, reviewCount: 0, breadType: BreadResponseType(breadTypeID: 0, name: "", isGlutenFree: false, isVegan: false, isNutFree: false, isSugarFree: false), homepage: "", address: "", openingTime: "", closedDay: "", phoneNumber: "", menuList: [MenuList(menuID: 0, menuName: "", menuPrice: 0)]) {
        didSet {
            self.collectionView.reloadData()
        }
    }
    private var reviewData: WrittenReviewsResponseDTO = WrittenReviewsResponseDTO(tastePercent: 0, specialPercent: 0, kindPercent: 0, zeroPercent: 0, totalReviewCount: 0, reviewList: [ReviewList(reviewID: 0, recommendKeywordList: [RecommendKeywordList(recommendKeywordID: 0, recommendKeywordName: "")], reviewText: "", memberNickname: "", createdAt: "")]) {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var bakeryID: Int?
    
    // MARK: - UI Property
    
    private let navigationBar = CustomNavigationBar()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let bakeryID = self.bakeryID else { return }
        getBakeryDetail(bakeryID: bakeryID)
        getWrittenReviews(bakeryID: bakeryID)
    }
    
    // MARK: - Setting
    
    override func setUI() {
        
        navigationBar.do {
            $0.addBackButtonAction(UIAction { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            $0.backgroundColor = .gbbWhite
            $0.configureBottomLine()
            $0.configureRightMapButton()
        }
        
        collectionView.do {
            $0.registerCells(cells: [TitleCollectionViewCell.self,
                                     InfoCollectionViewCell.self,
                                     MenuCollectionViewCell.self,
                                     ReviewCategoryCollectionViewCell.self,
                                     WrittenReviewsCollectionViewCell.self])
            $0.register(header: BakeryDetailCollectionViewHeader.self)
            $0.register(footer: BakeryDetailCollectionViewFooter.self)
            
            $0.backgroundColor = .gbbGray200
        }
    }
    
    override func setLayout() {
        
        view.addSubviews(collectionView, navigationBar)
        
        navigationBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setDelegate() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegate

extension BakeryDetailViewController: UICollectionViewDelegate { }

// MARK: - UICollectionViewDataSource

extension BakeryDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 2:
            return overviewData.menuList.count
        case 4:
            // TODO: EmptyView 구현 시 사용
            //            if reviewData.data.reviewList.isEmpty {
            //                return 1
            //            }
            return reviewData.reviewList.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: TitleCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            
            DispatchQueue.main.async {
                cell.updateUI(self.overviewData)
            }
            
            return cell
        case 1:
            let cell: InfoCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            
            DispatchQueue.main.async {
                cell.updateUI(self.overviewData)
            }
            
            return cell
        case 2:
            let cell: MenuCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            
            let menu = overviewData.menuList[indexPath.item]
            
            DispatchQueue.main.async {
                cell.updateUI(menu)
            }
            
            return cell
        case 3:
            let cell: ReviewCategoryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            
            DispatchQueue.main.async {
                cell.updateUI(self.reviewData)
            }
            
            return cell
        case 4:
            let cell: WrittenReviewsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            
            let review = reviewData.reviewList[indexPath.item]
            
            DispatchQueue.main.async {
                cell.updateUI(review)
            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch indexPath.section {
        case 1:
            let header: BakeryDetailCollectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, indexPath: indexPath)
            header.getType(.info)
            
            return header
        case 2:
            if kind == UICollectionView.elementKindSectionHeader {
                let header: BakeryDetailCollectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, indexPath: indexPath)
                header.getType(.menu)
                
                return header
            } else {
                let footer: BakeryDetailCollectionViewFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, indexPath: indexPath)
                
                return footer
            }
        case 3:
            let header: BakeryDetailCollectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, indexPath: indexPath)
            header.getType(.reviewCategory)
            
            return header
        case 4:
            let header: BakeryDetailCollectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, indexPath: indexPath)
            header.getType(.writtenReviews)
            
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BakeryDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            if !overviewData.isHACCP && !overviewData.isVegan && !overviewData.isNonGMO {
                return CGSize(width: getDeviceWidth(), height: 399)
            }
            return CGSize(width: getDeviceWidth(), height: 443)
        case 1:
            return CGSize(width: getDeviceWidth(), height: 235)
        case 2:
            return CGSize(width: getDeviceWidth(), height: 20)
        case 3:
            return CGSize(width: getDeviceWidth(), height: 134)
        case 4:
            return CGSize(width: getDeviceWidth() - 48, height: 173)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch section {
        case 1:
            return CGSize(width: collectionView.frame.width, height: 72)
        case 2:
            return CGSize(width: collectionView.frame.width, height: 64)
        case 3:
            return CGSize(width: collectionView.frame.width, height: 70)
        case 4:
            return CGSize(width: collectionView.frame.width, height: 77)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        switch section {
        case 2:
            return CGSize(width: collectionView.frame.width, height: 108)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch section {
        case 0:
            return UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        case 1:
            return UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
            //        case 2:
            //        case 3:
            //        case 4:
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}

// MARK: - API

extension BakeryDetailViewController {
    
    func getBakeryDetail(bakeryID: Int) {
        BakeryAPI.shared.getBakeryDetail(bakeryID: bakeryID) { response in
            
            guard let response = response else { return }
            guard let data = response.data else { return }
            
            self.overviewData = data
        }
    }
    
    func getWrittenReviews(bakeryID: Int) {
        BakeryAPI.shared.getWrittenReviews(bakeryID: bakeryID) { response in
            
            guard let response = response else { return }
            guard let data = response.data else { return }
            
            self.reviewData = data
        }
    }
}
