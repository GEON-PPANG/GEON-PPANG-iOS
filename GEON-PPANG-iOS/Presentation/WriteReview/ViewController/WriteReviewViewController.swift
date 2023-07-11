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
    
    // TODO: navigationBar 추가
    // TODO: bakeryImage 추가
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let bakeryOverviewView = BakeryOverviewView(bakeryImage: .actions, firstRegion: "tset", secondRegion: "efqerqf")
    private let lineView = LineView()
    private let likeCollectionViewFlowLayout = OptionsCollectionViewFlowLayout()
    private let optionsCollectionViewFlowLayout = OptionsCollectionViewFlowLayout()
    private lazy var likeCollectionView = OptionsCollectionView(frame: .zero, collectionViewLayout: likeCollectionViewFlowLayout)
    private lazy var optionsCollectionView = OptionsCollectionView(frame: .zero, collectionViewLayout: optionsCollectionViewFlowLayout)
    private let reviewDetailTextView = ReviewDetailTextView()
    private let aboutReviewLabel = UILabel()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: baseVC 에 숨기기
        self.navigationController?.navigationBar.isHidden = true
        setKeyboardHideGesture()
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
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.addSubview(bakeryOverviewView)
        bakeryOverviewView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(125)
        }
        
        contentView.addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(bakeryOverviewView.snp.bottom)
            $0.height.equalTo(1)
        }
        
        contentView.addSubview(likeCollectionView)
        likeCollectionView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(73)
        }
        
        contentView.addSubview(optionsCollectionView)
        optionsCollectionView.snp.makeConstraints {
            $0.top.equalTo(likeCollectionView.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(50)
        }
        
        contentView.addSubview(reviewDetailTextView)
        reviewDetailTextView.snp.makeConstraints {
            $0.top.equalTo(optionsCollectionView.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(221)
        }
        
        contentView.addSubview(aboutReviewLabel)
        aboutReviewLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(reviewDetailTextView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setUI() {
        likeCollectionViewFlowLayout.do {
            $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        optionsCollectionViewFlowLayout.do {
            $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        optionsCollectionView.do {
            $0.allowsMultipleSelection = true
        }
        
        aboutReviewLabel.do {
            $0.text = I18N.WriteReview.aboutReview
            $0.font = .captionM2
            $0.textColor = .gbbGray400
            $0.textAlignment = .left
            $0.numberOfLines = 4
        }
    }
    
    override func setDelegate() {
        likeCollectionView.delegate = self
        likeCollectionView.dataSource = self
        
        optionsCollectionView.delegate = self
        optionsCollectionView.dataSource = self
        
        reviewDetailTextView.detailTextView.delegate = self
    }
    
    // MARK: - Custom Method
    
    private func updateCollectionViewConstraint(of collectionView: UICollectionView) {
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        guard height != 0 else { return }
        collectionView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
    }
    
}

// MARK: - UICollectionViewDelegate extension

extension WriteReviewViewController: UICollectionViewDelegate {}

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
            cell.isUserInteractionEnabled = false
        default: return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: OptionsCollectionViewHeader  = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, indexPath: indexPath)
        
        switch collectionView {
        case likeCollectionView:
            header.configureTitle(to: I18N.WriteReview.likeOptionTitle)
            header.isEnabled.toggle()
        case optionsCollectionView:
            header.configureTitle(to: I18N.WriteReview.optionTitle)
        default:
            return UICollectionReusableView()
        }
        return header
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension WriteReviewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: 22)
    }
}

// MARK: - UITextViewDelegate

extension WriteReviewViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let textView = self.reviewDetailTextView.detailTextView
        if textView.text == I18N.WriteReview.likePlaceholder || textView.text == I18N.WriteReview.dislikePlaceholder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let textView = self.reviewDetailTextView.detailTextView
        if textView.text.isEmpty {
            textView.text = reviewDetailTextView.isLike ? I18N.WriteReview.likePlaceholder : I18N.WriteReview.dislikePlaceholder
            textView.textColor = .gbbGray300
        }
    }
}
