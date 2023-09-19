//
//  ReviewViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/09/05.
//

import UIKit

import SnapKit
import Then

final class ReviewViewController: BaseViewController {
    
    // MARK: - Property
    
    var type: ReviewViewType
    
    var bakeryData: SimpleBakeryModel
    
    var reviewID: Int?
    var myReviewData: MyReviewDetailResponseDTO?
    var reviewDate: String?
    
    var writeReviewData: WriteReviewRequestDTO = .init(bakeryID: 0, isLike: false, keywordList: [], reviewText: "")
    var source: AnalyticEventType = .HOME
    
    // MARK: - UI Property
    
    private let navigationBar = CustomNavigationBar()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private lazy var bottomView = BottomView()
    private lazy var nextButton = CommonButton()
    
    private lazy var reviewDateLabel = UILabel()
    private lazy var bakeryOverviewView = BakeryOverviewView(of: bakeryData)
    private let lineView = LineView()
    private let likeCollectionViewHeaderLabel = UILabel()
    private let likeCollectionView = OptionsCollectionView(frame: .zero, collectionViewLayout: OptionsCollectionViewFlowLayout())
    private let optionsCollectionViewHeaderLabel = UILabel()
    private let optionsCollectionView = OptionsCollectionView(frame: .zero, collectionViewLayout: OptionsCollectionViewFlowLayout())
    private lazy var reviewDetailTextView = ReviewDetailTextView(type: type)
    private lazy var aboutReviewContainerView = UIView()
    private lazy var aboutReviewLabel = UILabel()
    
    private lazy var backgroundView = BottomSheetAppearView()
    private lazy var exitBottomSheetView = WriteReviewBottomSheetView()
    private lazy var confirmBottomSheetView = CommonBottomSheet()
    
    // MARK: - Life Cycle
    
    init(
        type: ReviewViewType,
        bakeryData: SimpleBakeryModel
    ) {
        self.type = type
        self.bakeryData = bakeryData
        
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(
        type: ReviewViewType,
        bakeryData: SimpleBakeryModel,
        reviewID: Int,
        reviewDate: String
    ) {
        self.init(type: type, bakeryData: bakeryData)
        self.reviewID = reviewID
        self.reviewDate = reviewDate
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setKeyboardHideGesture()
        setupNotificationCenterOnScrollView()
        setWriteType()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard type == .read else { return }
        getReview()
        Utils.setDetailSourceType(self.source)
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview()
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(SizeLiteral.Screen.width)
        }
        
        contentView.addSubview(bakeryOverviewView)
        bakeryOverviewView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(type == .read ? 42 : 24)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(86)
        }
        
        contentView.addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(bakeryOverviewView.snp.bottom).offset(24)
            $0.height.equalTo(1)
        }
        
        contentView.addSubview(likeCollectionViewHeaderLabel)
        likeCollectionViewHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(22)
        }
        
        contentView.addSubview(likeCollectionView)
        likeCollectionView.snp.makeConstraints {
            $0.top.equalTo(likeCollectionViewHeaderLabel.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(37)
        }
        
        contentView.addSubview(optionsCollectionViewHeaderLabel)
        optionsCollectionViewHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(likeCollectionView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(22)
        }
        
        contentView.addSubview(optionsCollectionView)
        optionsCollectionView.snp.makeConstraints {
            $0.top.equalTo(optionsCollectionViewHeaderLabel.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(88)
        }
        
        contentView.addSubview(reviewDetailTextView)
        reviewDetailTextView.snp.makeConstraints {
            $0.top.equalTo(optionsCollectionView.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(221)
            $0.bottom.equalToSuperview().inset(11)
        }
    }
    
    override func setUI() {
        
        navigationBar.do {
            $0.backgroundColor = .white
            $0.configureCenterTitle(to: I18N.Review.myReview, with: .title2!)
            $0.configureBottomLine()
            $0.configureBackButtonAction(UIAction { [weak self] _ in
                self?.backButtonTapped()
            })
        }
        
        scrollView.do {
            $0.showsVerticalScrollIndicator = false
            $0.verticalScrollIndicatorInsets = .zero
            $0.backgroundColor = .white
            $0.bounces = false
        }
        
        contentView.do {
            $0.backgroundColor = .white
        }
        
        likeCollectionViewHeaderLabel.do {
            $0.text = I18N.Review.likeOptionTitle
            $0.font = .bodyB1
            $0.textColor = .gbbGray300
        }
        
        likeCollectionView.do {
            $0.toggleIsEnabled(to: false)
        }
        
        optionsCollectionViewHeaderLabel.do {
            $0.text = I18N.Review.optionTitle
            $0.font = .bodyB1
            $0.textColor = .gbbGray300
        }
        
        optionsCollectionView.do {
            $0.allowsMultipleSelection = true
            $0.isUserInteractionEnabled = false
        }
        
        reviewDetailTextView.do {
            $0.isUserInteractionEnabled = false
        }
        
        if type == .read {
            reviewDateLabel.do {
                $0.text = reviewDate
                $0.font = .captionM1
                $0.textColor = .gbbGray400
            }
        }
    }
    
    override func setDelegate() {
        
        likeCollectionView.dataSource = self
        optionsCollectionView.dataSource = self
    }
    
    // MARK: - Action Helper
    
    private func nextButtonTapped() {
        
        requestWriteReview(configureWriteReviewData())
        UIView.animate(withDuration: 0.2, animations: {
            self.bottomView.transform = .identity
            self.scrollView.transform = .identity
        }) { _ in
            self.backgroundView.dimmedView.isUserInteractionEnabled = false
            self.backgroundView.appearBottomSheetView(subView: self.confirmBottomSheetView, CGFloat().heightConsideringBottomSafeArea(292))
        }
        view.endEditing(true)
    }
    
    private func backButtonTapped() {
        
        if type == .read {
            self.navigationController?.popViewController(animated: true)
        } else {
            backgroundView.appearBottomSheetView(subView: exitBottomSheetView, CGFloat().heightConsideringBottomSafeArea(347))
        }
    }
    
    // MARK: - Custom Method
    
    private func configureCollectionViewHeader(to color: UIColor) {
        
        optionsCollectionViewHeaderLabel.do {
            $0.textColor = color
        }
    }
    
    private func textLimit(_ existingText: String?, to newText: String, with limit: Int) -> Bool {
        
        guard let text = existingText
        else { return false }
        let isOverLimit = text.count + newText.count <= limit
        return isOverLimit
    }
    
}

// MARK: - write type func

extension ReviewViewController {
    
    private func setWriteType() {
        
        guard type == .write else { return }
        setWriteTypeLayout()
        setWriteTypeUI()
        setWriteTypeDelegate()
        setupNotificationCenterOnScrollView()
    }
    
    private func setWriteTypeLayout() {
        
        contentView.addSubview(reviewDateLabel)
        reviewDateLabel.snp.makeConstraints {
            $0.bottom.equalTo(bakeryOverviewView.snp.top).offset(-3.5)
            $0.leading.equalTo(bakeryOverviewView)
        }
        
        reviewDetailTextView.snp.remakeConstraints {
            $0.top.equalTo(optionsCollectionView.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(196)
        }
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        contentView.addSubview(aboutReviewContainerView)
        aboutReviewContainerView.snp.makeConstraints {
            $0.top.equalTo(reviewDetailTextView.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        aboutReviewContainerView.addSubview(aboutReviewLabel)
        aboutReviewLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(CGFloat().heightConsideringBottomSafeArea(116))
        }
    }
    
    private func setWriteTypeUI() {
        
        likeCollectionViewHeaderLabel.do {
            $0.textColor = .gbbBlack
        }
        
        likeCollectionView.do {
            $0.isUserInteractionEnabled = true
        }
        
        aboutReviewContainerView.do {
            $0.backgroundColor = .gbbGray100
        }
        
        aboutReviewLabel.do {
            $0.text = I18N.Review.aboutReview
            $0.font = .captionM2
            $0.textColor = .gbbGray300
            $0.textAlignment = .left
            $0.numberOfLines = 4
            $0.setLineHeight(by: 1.37, with: I18N.Review.aboutReview)
        }
        
        bottomView.do {
            $0.backgroundColor = .white
            $0.layer.masksToBounds = false
            $0.applyAdditionalSubview(nextButton, withTopOffset: 20)
        }
        
        nextButton.do {
            $0.backgroundColor = .gbbPoint1
            $0.makeCornerRound(radius: 12)
            $0.configureButtonTitle(.write)
            $0.configureInteraction(to: false)
            $0.addAction(UIAction { [weak self] _ in
                self?.nextButtonTapped()
            }, for: .touchUpInside)
        }
        
        exitBottomSheetView.do {
            $0.dismissClosure = {
                self.backgroundView.dissmissFromSuperview()
                self.navigationController?.popViewController(animated: true)
            }
            $0.continueClosure = {
                self.backgroundView.dissmissFromSuperview()
            }
        }
        
        confirmBottomSheetView.do {
            $0.configureEmojiType(.smile)
            $0.configureBottonSheetTitle(I18N.Review.confirmSheetTitle)
            $0.dismissBottomSheet = {
                self.backgroundView.dissmissFromSuperview()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func setWriteTypeDelegate() {
        
        likeCollectionView.delegate = self
        optionsCollectionView.delegate = self
        scrollView.delegate = self
        reviewDetailTextView.detailTextView.delegate = self
    }
    
    private func setupNotificationCenterOnScrollView() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowOnScrollView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideOnScrollView), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configureWriteReviewData() -> WriteReviewRequestDTO {
        
        var requestData: WriteReviewRequestDTO = .empty()
        
        guard let isLike = likeCollectionView.cellForItem(at: [0, 0])?.isSelected,
              let keywordIndexPath = optionsCollectionView.indexPathsForSelectedItems
        else { return .empty() }
        
        let keywordList = keywordIndexPath.map {
            let keyword = KeywordDescriptionList.requestList[$0[1]]
            return SingleKeyword(keywordName: keyword)
        }
        
        requestData.bakeryID = bakeryData.id
        requestData.isLike = isLike
        requestData.keywordList = keywordList
        requestData.reviewText = reviewDetailTextView.detailTextView.text
        
        return requestData
    }
    
    private func bindReview(_ review: MyReviewDetailResponseDTO) {
        myReviewData = review
        likeCollectionView.reloadData()
        optionsCollectionView.reloadData()
        
        guard review.reviewText != "" else {
            reviewDetailTextView.detailTextView.text = I18N.Review.emptyReviewText
            return
        }
        reviewDetailTextView.configureTextView(to: .activated)
        reviewDetailTextView.detailTextView.text = review.reviewText
    }
    
}

// MARK: - write type objc func

extension ReviewViewController {
    
    @objc
    private func keyboardWillShowOnScrollView(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.bottomView.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 30)
                self.scrollView.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 30)
            })
        }
    }

    @objc
    private func keyboardWillHideOnScrollView(notification: NSNotification) {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.bottomView.transform = .identity
            self.scrollView.transform = .identity
        })
    }

}

// MARK: - UICollectionViewDelegate extension

extension ReviewViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case likeCollectionView:
            guard let isLikeSelected = collectionView.cellForItem(at: [0, 0])?.isSelected
            else { return }
            
            optionsCollectionView.toggleIsEnabled(to: isLikeSelected)
            
            configureCollectionViewHeader(to: isLikeSelected ? .black : .gbbGray300!)
            
            reviewDetailTextView.isLike = isLikeSelected
            reviewDetailTextView.isUserInteractionEnabled = !isLikeSelected
            reviewDetailTextView.configureTextView(to: isLikeSelected ? .deactivated : .activated)
            
            if !isLikeSelected {
                nextButton.configureInteraction(to: false)
            }
            
        case optionsCollectionView:
            let hasSelection = collectionView.indexPathsForSelectedItems != nil
            reviewDetailTextView.isUserInteractionEnabled = hasSelection
            reviewDetailTextView.configureTextView(to: hasSelection ? .activated : .deactivated)
            nextButton.configureInteraction(to: hasSelection)
            
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if optionsCollectionView.indexPathsForSelectedItems == [] {
            reviewDetailTextView.isUserInteractionEnabled = false
            reviewDetailTextView.configureTextView(to: .deactivated)
        }
    }
    
}

// MARK: - UICollectionViewDataSource extension

extension ReviewViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case likeCollectionView: return 2
        case optionsCollectionView: return 4
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: OptionsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        switch collectionView {
        case likeCollectionView:
            cell.configureCell(to: .deselected)
            cell.configureCellText(to: indexPath.item == 0 ? I18N.Review.like : I18N.Review.dislike)
        case optionsCollectionView:
            cell.configureCell(to: .disabled)
            cell.configureCellText(to: KeywordDescriptionList.keywordList[indexPath.item])
        default:
            return UICollectionViewCell()
        }
        
        if let data = myReviewData {
            switch collectionView {
            case likeCollectionView:
                if indexPath == [0, 0] {
                    cell.configureCell(to: data.isLike ? .selected : .disabled)
                } else {
                    cell.configureCell(to: !data.isLike ? .selected : .disabled)
                }
                
            case optionsCollectionView:
                let keywordList = data.recommendKeywordList
                    .map { $0.recommendKeywordName }
                _ = KeywordDescriptionList.keywordList
                    .filter {
                        keywordList.contains($0)
                    }
                    .map {
                        if cell.cellText == $0 {
                            cell.configureCell(to: .selected)
                        }
                    }
            default:
                break
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
    }
    
}

// MARK: - UITextViewDelegate

extension ReviewViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        let textCount = textView.text.count
        nextButton.configureInteraction(to: true)
        reviewDetailTextView.configureTextView(to: .activated)
        reviewDetailTextView.updateTextLimitLabel(to: textCount)
        
        reviewDetailTextView.placeholderLabel.isHidden = !textView.text.isEmpty
        
        let textViewText = textView.text.replacingOccurrences(of: " ", with: "")
        if textViewText.isEmpty && !reviewDetailTextView.isLike {
            nextButton.configureInteraction(to: false)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        reviewDetailTextView.placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        
        return self.textLimit(textView.text, to: text, with: 120)
    }
}

// MARK: API

extension ReviewViewController {
    
    func getReview() {
        
        guard let id = reviewID else { return }
        ReviewAPI.shared.getMyReviewDetail(of: id) { response in
            guard let response = response,
                  let data = response.data
            else { return }
            self.bindReview(data)
        }
    }
    
    func requestWriteReview(_ content: WriteReviewRequestDTO) {
        
        ReviewAPI.shared.postWriteReview(content: content) { response in
            guard let response = response else { return }
            guard let data = response.data else { return }
            dump(data)
        }
    }
}
