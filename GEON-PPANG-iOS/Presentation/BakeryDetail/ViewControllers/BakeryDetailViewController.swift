//
//  BakeryDetailViewController.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/13.
//

import UIKit

import SnapKit
import Then
import SafariServices

final class BakeryDetailViewController: BaseViewController {
    
    // MARK: - Property
    
    private var overviewData: BakeryDetailResponseDTO = .initialDTO() {
        didSet {
            if self.detailBottomView.check {
                let indexPath = IndexPath(item: 0, section: 0)
                
                UIView.performWithoutAnimation {
                    self.collectionView.reconfigureItems(at: [indexPath])
                }
            } else {
                UIView.performWithoutAnimation {
                    self.collectionView.reloadSections(IndexSet(integersIn: 0 ... 2))
                }
            }
        }
    }
    private var reviewData: WrittenReviewsResponseDTO = .initialDTO() {
        didSet {
            UIView.performWithoutAnimation {
                self.collectionView.reloadSections(IndexSet(integersIn: 3 ... 4))
            }
        }
    }
    private var isBookmarked: Bool = false
    var bakeryID: Int?
    var homepageURL: String = ""
    var instagramURL: String = ""
    
    // MARK: - UI Property
    
    private let navigationBar = CustomNavigationBar()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var floatingButton = UIButton()
    private lazy var detailBottomView = DetailBottomView()
    private let tempLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let bakeryID = self.bakeryID else { return }
        
        getBakeryDetail(bakeryID: bakeryID, isUpdated: true)
                
        navigationController?.interactivePopGestureRecognizer?.delegate = nil // swipe back gesture
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        view.addSubview(floatingButton)
        floatingButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(heightConsideringNotch(158))
            $0.size.equalTo(48)
        }
        
        view.addSubview(detailBottomView)
        detailBottomView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func setUI() {
        
        navigationBar.do {
            $0.configureBackButtonAction(popViewControllerAction())
            $0.configureBottomLine()
            $0.configureRightMapButton()
            $0.tappedMapButton = {
                guard let url = URL(string: self.overviewData.mapURL) else { return }
                AnalyticManager.log(event: .detail(.clickNavigation))
                let safariVC = SFSafariViewController(url: url)
                self.present(safariVC, animated: true, completion: nil)
            }
        }
        
        collectionView.do {
            $0.registerCells(cells: [TitleCollectionViewCell.self,
                                     InfoCollectionViewCell.self,
                                     MenuCollectionViewCell.self,
                                     ReviewCategoryCollectionViewCell.self,
                                     WrittenReviewsCollectionViewCell.self,
                                     EmptyCollectionViewCell.self])
            $0.register(header: BakeryDetailCollectionViewHeader.self)
            $0.register(footer: BakeryDetailCollectionViewFooter.self)
            
            $0.backgroundColor = .gbbGray200
            $0.bounces = false
            $0.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 92, right: 0)
            $0.showsVerticalScrollIndicator = false
        }
        
        floatingButton.do {
            $0.setImage(.upArrowIcon, for: .normal)
            $0.backgroundColor = .gbbWhite
            $0.makeBorder(width: 1, color: .gbbGray200!)
            $0.makeCornerRound(radius: 24)
            $0.addAction(UIAction { [weak self] _ in
                self?.tappedFloatingButton()
            }, for: .touchUpInside)
        }
        
        detailBottomView.do {
            $0.check = false
            $0.backgroundColor = .gbbWhite
            $0.tappedBookmarkButton = {
                self.detailBottomView.check = true
                self.requestBakeryBookmark(!self.isBookmarked)
                if !self.isBookmarked {
                    self.showToast(message: I18N.Detail.addBookmark)
                } else {
                    self.showToast(message: I18N.Detail.delBookmark)
                }
            }
            $0.tappedWriteReviewButton = {
                AnalyticManager.log(event: .writeReview(.startReviewWriting))
                Utils.push(self.navigationController, ReviewViewController(
                    type: .write,
                    bakeryData: self.configureSimpleBakeryData()))
            }
        }
        
        tempLabel.do {
            $0.basic(font: .subHead!, color: .gbbGray400!)
            $0.numberOfLines = 0
        }
    }
    
    override func setDelegate() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Custom Method
    
    private func configureSimpleBakeryData() -> SimpleBakeryModel {
        
        var bakeryData = SimpleBakeryModel.emptyModel()
        bakeryData.id = overviewData.bakeryID
        bakeryData.name = overviewData.bakeryName
        bakeryData.imageURL = overviewData.bakeryPicture
        bakeryData.ingredients = overviewData.breadType.configureTrueOptions().filter { $0.1 == true }.map { $0.0 }
        bakeryData.region = [overviewData.firstNearStation, overviewData.secondNearStation]
        bakeryData.certificates = .init(
            isHACCP: overviewData.isHACCP,
            isVegan: overviewData.isVegan,
            isNonGMO: overviewData.isNonGMO
        )
        
        return bakeryData
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
            let reviewList = reviewData.reviewList
            
            return reviewList.isEmpty ? 1 : reviewList.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: TitleCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            
            DispatchQueue.main.async {
                cell.configureCellUI(self.overviewData)
            }
            
            return cell
        case 1:
            let cell: InfoCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            
            DispatchQueue.main.async {
                cell.configureCellUI(self.overviewData)
            }
            
            cell.delegate = self
            
            return cell
        case 2:
            let cell: MenuCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let menu = overviewData.menuList[indexPath.item]
            
            DispatchQueue.main.async {
                cell.configureCellUI(menu)
            }
            
            return cell
        case 3:
            let cell: ReviewCategoryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            
            DispatchQueue.main.async {
                cell.configureCellUI(self.reviewData)
            }
            
            return cell
        case 4:
            if reviewData.reviewList.isEmpty {
                let cell: EmptyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configureViewType(.noReview)
                
                return cell
            } else {
                let cell: WrittenReviewsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                let review = reviewData.reviewList[indexPath.item]
                
                DispatchQueue.main.async {
                    self.tempLabel.text = review.reviewText
                    let maxSize = CGSize(width: self.convertByWidthRatio(277), height: CGFloat.greatestFiniteMagnitude)
                    let labelSize = self.tempLabel.sizeThatFits(maxSize)
                    
                    cell.configureCellUI(review, labelSize.height)
                }
                
                cell.delegate = self
                
                return cell
            }
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch indexPath.section {
        case 1:
            let header: BakeryDetailCollectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, indexPath: indexPath)
            
            header.configureHeaderUI(self.overviewData)
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
            
            DispatchQueue.main.async {
                header.configureHeaderUI(self.overviewData)
                header.getType(.writtenReviews)
            }
            
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
            let cellHeight: CGFloat = (!overviewData.isHACCP && !overviewData.isVegan && !overviewData.isNonGMO) ? 399 : 443
            
            return CGSize(width: getDeviceWidth(), height: cellHeight)
        case 1:
            return CGSize(width: getDeviceWidth(), height: 263)
        case 2:
            return CGSize(width: getDeviceWidth(), height: 32)
        case 3:
            return CGSize(width: getDeviceWidth(), height: 142)
        case 4:
            if reviewData.reviewList.isEmpty {
                return CGSize(width: getDeviceWidth(), height: 293)
            } else {
                tempLabel.text = reviewData.reviewList[indexPath.item].reviewText
                let maxSize = CGSize(width: convertByWidthRatio(277), height: CGFloat.greatestFiniteMagnitude)
                let labelSize = tempLabel.sizeThatFits(maxSize)
                
                let cellHeight = reviewData.reviewList[indexPath.item].recommendKeywordList.isEmpty ? labelSize.height + 88 : labelSize.height + 123
                
                return CGSize(width: getDeviceWidth(), height: cellHeight)
            }
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch section {
        case 1:
            let headerHeight: CGFloat = overviewData.homepageURL == "" ? 50 : 76
            
            return CGSize(width: collectionView.frame.width, height: headerHeight)
        case 2:
            return CGSize(width: collectionView.frame.width, height: 68)
        case 3:
            return CGSize(width: collectionView.frame.width, height: 74)
        case 4:
            return CGSize(width: collectionView.frame.width, height: 79)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        switch section {
        case 2:
            return CGSize(width: collectionView.frame.width, height: 112)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch section {
        case 0, 1:
            return UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        case 4:
            return UIEdgeInsets(top: 0, left: 0, bottom: 92, right: 0)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
}

// MARK: - API

extension BakeryDetailViewController {
    
    func getBakeryDetail(bakeryID: Int, isUpdated: Bool) {
        
        BakeriesAPI.shared.getBakeryDetail(bakeryID: bakeryID) { response in
            
            guard let response = response else { return }
            guard let data = response.data else { return }
            dump(data)
            
            self.overviewData = data
            self.isBookmarked = data.isBookMarked
            self.detailBottomView.configureBookmarkButton(to: data.isBookMarked)
            self.homepageURL = data.homepageURL
            self.instagramURL = data.instagramURL
            self.getWrittenReviews(bakeryID: bakeryID, isUpdated: isUpdated)
        }
    }
    
    func getWrittenReviews(bakeryID: Int, isUpdated: Bool) {
        
        if isUpdated {
            BakeriesAPI.shared.getBakeryReviews(bakeryID: bakeryID) { response in
                
                guard let response = response else { return }
                guard let data = response.data else { return }
                dump(data)
                
                self.reviewData = data
            }
        }
    }
    
    private func requestBakeryBookmark(_ value: Bool) {
        
        let bookmarkRequest = BookmarkRequestDTO(isAddingBookMark: value)
        
        guard let bakeryID = self.bakeryID else { return }
        
//        BakeriesAPI.shared.postBookmark(bakeryID: bakeryID, with: bookmarkRequest) { _ in
//            
//            AnalyticManager.log(event: .detail(.clickMystore))
//            self.detailBottomView.configureBookmarkButton(to: value)
//            self.isBookmarked = value
//            self.getBakeryDetail(bakeryID: bakeryID, isUpdated: false)
//        }
    }
    
    private func showToast(message: String) {
        
        let toastLabel = UILabel()
        let toastWidth = isBookmarked ? 181.0 : 141.0
        let toastHeight = 45.0
        
        view.addSubview(toastLabel)
        toastLabel.frame = CGRect(x: getDeviceWidth() / 2 - toastWidth / 2,
                                  y: getDeviceHeight() - toastHeight - 154,
                                  width: toastWidth,
                                  height: toastHeight)
        
        toastLabel.backgroundColor = .gbbGray600
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = .bodyB2
        toastLabel.text = message
        toastLabel.alpha = 0.9
        toastLabel.makeCornerRound(radius: 22.5)
        
        UIView.animate(withDuration: 1.5,
                       delay: 0.1,
                       options: .curveEaseOut,
                       animations: { toastLabel.alpha = 0.0 },
                       completion: { (_) in toastLabel.removeFromSuperview() })
    }
    
    private func tappedFloatingButton() {
        
        collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}
