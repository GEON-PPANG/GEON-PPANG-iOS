//
//  WriteReviewViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/06.
//

import UIKit

import SnapKit
import Then

final class WriteReviewViewController: BaseViewController {
    
    // MARK: - Property
    
    private var likeCollectionViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - UI Property
    
    // TODO: bakeryImage 추가
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let navigationBar = CustomNavigationBar()
    private let bakeryOverviewView = BakeryOverviewView(bakeryImage: .actions, firstRegion: "tset", secondRegion: "efqerqf")
    private let lineView = LineView()
    private let likeCollectionViewFlowLayout = OptionsCollectionViewFlowLayout()
    private let optionsCollectionViewFlowLayout = OptionsCollectionViewFlowLayout()
    private let likeCollectionViewHeaderLabel = UILabel()
    private lazy var likeCollectionView = OptionsCollectionView(frame: .zero, collectionViewLayout: likeCollectionViewFlowLayout)
    private let optionsCollectionViewHeaderLabel = UILabel()
    private lazy var optionsCollectionView = OptionsCollectionView(frame: .zero, collectionViewLayout: optionsCollectionViewFlowLayout)
    private let reviewDetailTextView = ReviewDetailTextView()
    private let dotView = UILabel()
    private let aboutReviewContainerView = UIView()
    private let aboutReviewLabel = UILabel()
    private let bottomView = BottomView()
    private let bottomDummyView = UIView()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarHidden()
        setKeyboardHideGesture()
        setKeyboardNotificationCenterOnScrollView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        updateCollectionViewConstraint(of: likeCollectionView)
        updateCollectionViewConstraint(of: optionsCollectionView)
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
        }
        
        contentView.addSubview(bakeryOverviewView)
        bakeryOverviewView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(68)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(125)
        }
        
        contentView.addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(bakeryOverviewView.snp.bottom)
            $0.height.equalTo(1)
        }
        
        contentView.addSubview(likeCollectionViewHeaderLabel)
        likeCollectionViewHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(24)
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
            $0.horizontalEdges.equalToSuperview().inset(24)
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
            $0.height.equalTo(207)
            $0.bottom.equalToSuperview()
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
            $0.configureLeftTitle(to: "건대 초코빵")
            $0.configureBottomLine()
        }
        
        scrollView.do {
            $0.showsVerticalScrollIndicator = false
            $0.verticalScrollIndicatorInsets = .zero
            $0.backgroundColor = .gbbGray100
        }
        
        contentView.do {
            $0.backgroundColor = .white
        }
        
        likeCollectionViewFlowLayout.do {
            $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        optionsCollectionViewFlowLayout.do {
            $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
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
            $0.applyAdditionalSubview(bottomDummyView, withTrailingOffset: 16)
        }
        
        bottomDummyView.do {
            $0.backgroundColor = .gbbPoint1
            $0.makeCornerRound(radius: 12)
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
    
    private func setKeyboardNotificationCenterOnScrollView() {
        NotificationCenter.default.addObserver(self, selector: #selector(moveUpAboutKeyboardOnScrollView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveDownAboutKeyboardOnScrollView), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Custom Method
    
    private func updateCollectionViewConstraint(of collectionView: UICollectionView) {
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        guard height != 0 else { return }
        collectionView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
    }
    
    private func configureCollectionViewHeader(to color: UIColor) {
        optionsCollectionViewHeaderLabel.do {
            $0.textColor = color
        }
    }
    
    private func checkTextViewLength(_ textView: UITextView) {
        if textView.text.count <= 10 {
            reviewDetailTextView.configureTextView(to: .error)
        } else {
            reviewDetailTextView.configureTextView(to: .activated)
        }
    }
    
    private func textLimit(_ existingText: String?, to newText: String, with limit: Int) -> Bool {
        guard let text = existingText
        else { return false }
        let isOverLimit = text.count + newText.count <= limit
        return isOverLimit
    }
    
    // MARK: - objc
    
    @objc
    func moveUpAboutKeyboardOnScrollView(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.scrollView.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 24)
                self.bottomView.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 40)
            })
        }
    }
    
    @objc
    func moveDownAboutKeyboardOnScrollView(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.scrollView.transform = .identity
            self.bottomView.transform = .identity
            self.bottomDummyView.transform = .identity
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
            configureCollectionViewHeader(to: isLikeSelected ? .black : .gbbGray300!)
            
            reviewDetailTextView.isLike = isLikeSelected
            reviewDetailTextView.isUserInteractionEnabled = !isLikeSelected
            reviewDetailTextView.configureTextView(to: isLikeSelected ? .deactivated : .activated)
            
        case optionsCollectionView:
            let hasSelection = collectionView.indexPathsForSelectedItems != nil
            reviewDetailTextView.isUserInteractionEnabled = hasSelection
            reviewDetailTextView.configureTextView(to: hasSelection ? .activated : .deactivated)
            reviewDetailTextView.checkTextCount()
            
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard collectionView == optionsCollectionView else { return }
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
            let keywordList = KeywordList.Keyword.allCases.map { $0.rawValue }
            cell.configureCell(to: .disabled)
            cell.configureCellText(to: keywordList[indexPath.item])
        default:
            return UICollectionViewCell()
        }
        return cell
    }
    
}

// MARK: - UITextViewDelegate

extension WriteReviewViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let textCount = textView.text.count
        if textCount < 10 && 0 < textCount {
            reviewDetailTextView.configureTextView(to: .error)
        } else {
            reviewDetailTextView.configureTextView(to: .activated)
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
