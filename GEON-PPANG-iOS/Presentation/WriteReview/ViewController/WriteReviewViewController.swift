//
//  WriteReviewViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/06.
//

import UIKit

import Kingfisher
import SnapKit
import Then

final class WriteReviewViewController: BaseViewController {
    
    // MARK: - Property
    
    private let keywordList = KeywordDescriptionList.Keyword.allCases.map { $0.rawValue }
    private let keywordRequestList = KeywordDescriptionList.Request.allCases.map { $0.rawValue }
    
    private var bakeryData: SimpleBakeryModel
    private var writeReviewData: WriteReviewRequestDTO = .init(bakeryID: 0, isLike: false, keywordList: [], reviewText: "")
    
    // MARK: - UI Property
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let navigationBar = CustomNavigationBar()
    private let bottomView = BottomView()
    private let nextButton = CommonButton()
    
    private lazy var bakeryOverviewView = BakeryOverviewView(
        bakeryImage: bakeryData.bakeryImageURL,
        ingredients: bakeryData.bakeryIngredients,
        firstRegion: bakeryData.bakeryRegion[0],
        secondRegion: bakeryData.bakeryRegion[1]
    )
    
    private let lineView = LineView()
    
    private let likeCollectionViewFlowLayout = OptionsCollectionViewFlowLayout()
    private let optionsCollectionViewFlowLayout = OptionsCollectionViewFlowLayout()
    private let likeCollectionViewHeaderLabel = UILabel()
    private lazy var likeCollectionView = OptionsCollectionView(frame: .zero, collectionViewLayout: likeCollectionViewFlowLayout)
    private let optionsCollectionViewHeaderLabel = UILabel()
    private lazy var optionsCollectionView = OptionsCollectionView(frame: .zero, collectionViewLayout: optionsCollectionViewFlowLayout)
    
    private let reviewDetailTextView = ReviewDetailTextView()
    private let aboutReviewContainerView = UIView()
    private let dotView = UILabel()
    private let aboutReviewLabel = UILabel()
    
    private let backgroundView = BottomSheetAppearView()
    private let exitBottomSheetView = WriteReviewBottomSheetView()
    private let confirmBottomSheetView = CommonBottomSheet()
    
    // MARK: - life cycle
    
    init(bakeryData: SimpleBakeryModel) {
        self.bakeryData = bakeryData
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarHidden()
        setKeyboardHideGesture()
        setupNotificationCenterOnScrollView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        Utils.updateCollectionViewConstraint(of: bakeryOverviewView.bakeryIngredientsCollectionView, byOffset: 1)
        Utils.updateCollectionViewConstraint(of: likeCollectionView)
        Utils.updateCollectionViewConstraint(of: optionsCollectionView)
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview()
        }
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(SizeLiteral.Screen.width)
        }
        
        contentView.addSubview(bakeryOverviewView)
        bakeryOverviewView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIScreen.main.hasNotch ? 92 : 96)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        contentView.addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
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
            $0.height.equalTo(73)
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
            $0.height.equalTo(50)
        }
        
        contentView.addSubview(reviewDetailTextView)
        reviewDetailTextView.snp.makeConstraints {
            $0.top.equalTo(optionsCollectionView.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(221)
        }
        
        contentView.addSubview(aboutReviewContainerView)
        aboutReviewContainerView.snp.makeConstraints {
            $0.top.equalTo(reviewDetailTextView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(207)
        }
        
        aboutReviewContainerView.addSubview(dotView)
        dotView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalToSuperview().offset(16)
        }
        
        aboutReviewContainerView.addSubview(aboutReviewLabel)
        aboutReviewLabel.snp.makeConstraints {
            $0.leading.equalTo(dotView.snp.trailing)
            $0.trailing.equalToSuperview().inset(24)
            $0.top.equalToSuperview().offset(16)
        }
    }
    
    override func setUI() {
        navigationBar.do {
            $0.backgroundColor = .white
            $0.configureLeftTitle(to: bakeryData.bakeryName)
            $0.configureBottomLine()
            $0.addBackButtonAction(UIAction { [weak self] _ in
                self?.backButtonTapped()
            })
        }
        
        scrollView.do {
            $0.showsVerticalScrollIndicator = false
            $0.verticalScrollIndicatorInsets = .zero
            $0.backgroundColor = .gbbGray100
        }
        
        contentView.do {
            $0.backgroundColor = .white
        }
        
        likeCollectionViewHeaderLabel.do {
            $0.text = I18N.WriteReview.likeOptionTitle
            $0.font = .bodyB1
            $0.textColor = .black
        }
        
        optionsCollectionViewHeaderLabel.do {
            $0.text = I18N.WriteReview.optionTitle
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
        
        aboutReviewContainerView.do {
            $0.backgroundColor = .gbbGray100
        }
        
        dotView.do {
            $0.font = .captionM2
            $0.textColor = .gbbGray300
            $0.textAlignment = .center
            $0.setLineHeight(by: 1.37, with: "•")
        }
        
        aboutReviewLabel.do {
            $0.text = I18N.WriteReview.aboutReview
            $0.font = .captionM2
            $0.textColor = .gbbGray300
            $0.textAlignment = .left
            $0.numberOfLines = 4
            $0.setLineHeight(by: 1.37, with: I18N.WriteReview.aboutReview)
        }
        
        bottomView.do {
            $0.backgroundColor = .white
            $0.layer.masksToBounds = false
            $0.applyAdditionalSubview(nextButton, withTopOffset: 20)
        }
        
        nextButton.do {
            $0.backgroundColor = .gbbPoint1
            $0.isUserInteractionEnabled = false
            $0.makeCornerRound(radius: 12)
            $0.getButtonTitle(.write)
            $0.getButtonUI(.gbbGray200!)
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
            $0.getEmojiType(.smile)
            $0.getBottonSheetTitle(I18N.WriteReview.confirmSheetTitle)
            $0.dismissClosure = {
                self.backgroundView.dissmissFromSuperview()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func setDelegate() {
        scrollView.delegate = self
        
        likeCollectionView.delegate = self
        likeCollectionView.dataSource = self
        
        optionsCollectionView.delegate = self
        optionsCollectionView.dataSource = self
        
        reviewDetailTextView.detailTextView.delegate = self
    }
    
    private func setupNotificationCenterOnScrollView() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowOnScrollView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideOnScrollView), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Action Helper
    
    private func nextButtonTapped() {
        writeReviewData.reviewText = reviewDetailTextView.detailTextView.text
//        requestWriteReview(writeReviewData)
        UIView.animate(withDuration: 0.2, animations: {
            self.bottomView.transform = .identity
            self.scrollView.transform = .identity
        }) { _ in
            self.backgroundView.dimmedView.isUserInteractionEnabled = false
            self.backgroundView.appearBottomSheetView(subView: self.confirmBottomSheetView, CGFloat().heightConsideringBottomSafeArea(281))
        }
        view.endEditing(true)
        dump(writeReviewData)
    }
    
    private func backButtonTapped() {
        backgroundView.appearBottomSheetView(subView: exitBottomSheetView, CGFloat().heightConsideringBottomSafeArea(309))
    }
    
    // MARK: - Custom Method
    
    private func configureCollectionViewHeader(to color: UIColor) {
        optionsCollectionViewHeaderLabel.do {
            $0.textColor = color
        }
    }
    
    private func checkTextViewLength(_ textView: UITextView) {
        reviewDetailTextView.configureTextView(to: textView.text.count <= 10 ? .error : .activated)
    }
    
    private func textLimit(_ existingText: String?, to newText: String, with limit: Int) -> Bool {
        guard let text = existingText
        else { return false }
        let isOverLimit = text.count + newText.count <= limit
        return isOverLimit
    }
    
    func configureBakeryData() {
        
    }
    
    // MARK: - objc
    
    @objc
    private func keyboardWillShowOnScrollView(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.bottomView.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 30)
                self.scrollView.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height)
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

extension WriteReviewViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case likeCollectionView:
            guard let isLikeSelected = collectionView.cellForItem(at: [0, 0])?.isSelected
            else { return }
            
            optionsCollectionView.toggleIsEnabled(to: isLikeSelected)
            if !isLikeSelected {
                writeReviewData.keywordList.removeAll()
            }
            
            configureCollectionViewHeader(to: isLikeSelected ? .black : .gbbGray300!)
            
            reviewDetailTextView.isLike = isLikeSelected
            reviewDetailTextView.isUserInteractionEnabled = !isLikeSelected
            reviewDetailTextView.configureTextView(to: isLikeSelected ? .deactivated : .activated)
            
            writeReviewData.isLike = isLikeSelected
            
        case optionsCollectionView:
            let hasSelection = collectionView.indexPathsForSelectedItems != nil
            reviewDetailTextView.isUserInteractionEnabled = hasSelection
            reviewDetailTextView.configureTextView(to: hasSelection ? .activated : .deactivated)
            reviewDetailTextView.checkTextCount()
            
            writeReviewData.keywordList.append(SingleKeyword(keywordName: keywordRequestList[indexPath.item]))
            
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard collectionView == optionsCollectionView else { return }
        
        if let keywordIndex = writeReviewData.keywordList.firstIndex(of: SingleKeyword(keywordName: keywordRequestList[indexPath.item])) {
            writeReviewData.keywordList.remove(at: keywordIndex)
        }
        
        if collectionView.indexPathsForSelectedItems == [] {
            reviewDetailTextView.isUserInteractionEnabled = false
            reviewDetailTextView.configureTextView(to: .deactivated)
        }
    }
    
}

// MARK: - UICollectionViewDataSource extension

extension WriteReviewViewController: UICollectionViewDataSource {
    
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
            cell.configureCellText(to: indexPath.item == 0 ? I18N.WriteReview.like : I18N.WriteReview.dislike)
        case optionsCollectionView:
            cell.configureCell(to: .disabled)
            cell.configureCellText(to: keywordList[indexPath.item])
        default:
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
    }
    
}

// MARK: - UITextViewDelegate

extension WriteReviewViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let textCount = textView.text.count
        if textCount < 10 && 0 < textCount {
            reviewDetailTextView.configureTextView(to: .error)
            
            nextButton.getButtonUI(.gbbGray200!)
            nextButton.isUserInteractionEnabled = false
        } else {
            reviewDetailTextView.configureTextView(to: .activated)
            
            nextButton.getButtonUI(.gbbGray700!)
            nextButton.isUserInteractionEnabled = true
        }
        reviewDetailTextView.updateTextLimitLabel(to: textCount)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == I18N.WriteReview.likePlaceholder || textView.text == I18N.WriteReview.dislikePlaceholder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = reviewDetailTextView.isLike ? I18N.WriteReview.likePlaceholder : I18N.WriteReview.dislikePlaceholder
            textView.textColor = .gbbGray300
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return self.textLimit(textView.text, to: text, with: 70)
    }
}

// MARK: API

extension WriteReviewViewController {
    func requestWriteReview(_ content: WriteReviewRequestDTO) {
        BakeryAPI.shared.postWriteReview(content: content) { response in
            guard let response = response else { return }
            guard let data = response.data else { return }
            dump(data)
        }
    }
}
