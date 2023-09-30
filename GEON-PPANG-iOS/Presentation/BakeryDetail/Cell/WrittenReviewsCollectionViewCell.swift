//
//  WrittenReviewsCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/18.
//

import UIKit

import SnapKit
import Then

protocol ReportButtonDelegate: BakeryDetailViewController {
    
    func tappedReportButton(reviewID: Int)
}

final class WrittenReviewsCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: ReportButtonDelegate?
    
    private var reviewID: Int?
    
    // MARK: - UI Property
    
    private let reviewContainer = UIView()
    private let profileImage = UIImageView()
    private let userNicknameLabel = UILabel()
    private let reviewDateLabel = UILabel()
    private let reportButton = UIButton()
    private lazy var reviewCategoryStackView = ReviewCategoryStackView()
    private let reviewTextLabel = UILabel()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        contentView.addSubview(reviewContainer)
        reviewContainer.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(convertByWidthRatio(24))
            $0.width.equalTo(convertByWidthRatio(327))
            $0.height.equalTo(231)
        }
        
        reviewContainer.addSubview(profileImage)
        profileImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(convertByWidthRatio(25))
            $0.size.equalTo(20)
        }
        
        reviewContainer.addSubview(userNicknameLabel)
        userNicknameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImage)
            $0.leading.equalTo(profileImage.snp.trailing).offset(convertByWidthRatio(7))
            $0.width.equalTo(convertByWidthRatio(125))
            $0.height.equalTo(19)
        }
        
        reviewContainer.addSubview(reviewDateLabel)
        reviewDateLabel.snp.makeConstraints {
            $0.centerY.equalTo(userNicknameLabel)
            $0.trailing.equalToSuperview().inset(convertByWidthRatio(59))
            $0.width.equalTo(convertByWidthRatio(67))
            $0.height.equalTo(17)
        }
        
        reviewContainer.addSubview(reportButton)
        reportButton.snp.makeConstraints {
            $0.centerY.equalTo(userNicknameLabel)
            $0.trailing.equalToSuperview().inset(convertByWidthRatio(25))
            $0.width.equalTo(convertByWidthRatio(23))
            $0.height.equalTo(17)
        }
        
        reviewContainer.addSubview(reviewCategoryStackView)
        reviewCategoryStackView.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(10)
            $0.leading.equalTo(profileImage)
        }
        
        reviewContainer.addSubview(reviewTextLabel)
        reviewTextLabel.snp.makeConstraints {
            $0.top.equalTo(reviewCategoryStackView.snp.bottom).offset(16)
            $0.directionalHorizontalEdges.equalToSuperview().inset(convertByWidthRatio(25))
            $0.width.equalTo(convertByWidthRatio(277))
            $0.height.equalTo(120)
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.backgroundColor = .gbbWhite
        }
        
        reviewContainer.do {
            $0.backgroundColor = .gbbBackground1
            $0.makeCornerRound(radius: 12)
            $0.makeBorder(width: 1, color: .gbbGray300!)
        }
        
        profileImage.do {
            $0.image = .smileIcon
            $0.contentMode = .scaleToFill
        }
        
        userNicknameLabel.do {
            $0.basic(font: .bodyB2!, color: .gbbMain1!)
        }
        
        reviewDateLabel.do {
            $0.basic(font: .captionM1!, color: .gbbGray400!)
            $0.textAlignment = .right
        }
        
        reportButton.do {
            $0.setTitle(I18N.Detail.report, for: .normal)
            $0.setTitleColor(.gbbGray300, for: .normal)
            $0.titleLabel?.font = .captionM1
            $0.addAction(UIAction { [weak self] _ in
                self?.tappedReportButton()
            }, for: .touchUpInside)
        }
        
        reviewTextLabel.do {
            $0.basic(font: .subHead!, color: .gbbGray400!)
            $0.numberOfLines = 0
        }
    }
    
    // MARK: - Custom Method
    
    func configureCellUI(_ data: ReviewList, _ labelHeight: CGFloat) {
        
        reviewID = data.reviewID
        userNicknameLabel.text = data.memberNickname
        reviewDateLabel.text = data.createdAt
        reviewTextLabel.text = data.reviewText
        
        let isKeywordListEmpty = data.recommendKeywordList.isEmpty
        
        if !isKeywordListEmpty {
            let keywordIDs = data.recommendKeywordList.map {
                $0.recommendKeywordID
            }
            reviewCategoryStackView.getChipStatus(keywordIDs)
        } else {
            reviewCategoryStackView.getNoRecommend()
        }
        
        let containerHeight = isKeywordListEmpty ? labelHeight + 76 : labelHeight + 111
        let textLabelTopConstraint = isKeywordListEmpty ? profileImage.snp.bottom : reviewCategoryStackView.snp.bottom
        
        reviewContainer.snp.remakeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(convertByWidthRatio(24))
            $0.width.equalTo(convertByWidthRatio(327))
            $0.height.equalTo(containerHeight)
        }
        
        reviewTextLabel.snp.remakeConstraints {
            $0.top.equalTo(textLabelTopConstraint).offset(16)
            $0.directionalHorizontalEdges.equalToSuperview().inset(convertByWidthRatio(25))
            $0.width.equalTo(convertByWidthRatio(277))
            $0.height.equalTo(labelHeight)
        }
    }
    
    func tappedReportButton() {
        
        guard let reviewID = reviewID else { return }
        delegate?.tappedReportButton(reviewID: reviewID)
    }
}

// MARK: - Custom Protocol

extension BakeryDetailViewController: ReportButtonDelegate {
    
    func tappedReportButton(reviewID: Int) {
        
        AnalyticManager.log(event: .reportReview(.startReviewReport))
        Utils.push(self.navigationController, ReportViewController(title: I18N.Detail.reviewReport, reviewID: reviewID))
    }
}
