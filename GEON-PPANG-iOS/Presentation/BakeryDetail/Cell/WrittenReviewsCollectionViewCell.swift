//
//  WrittenReviewsCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/18.
//

import UIKit

import SnapKit
import Then

final class WrittenReviewsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private let reviewContainer = UIView()
    private let profileImage = UIImageView()
    private let userNicknameLabel = UILabel()
    private let reviewDateLabel = UILabel()
    private let reportLabel = UILabel()
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
            $0.height.equalTo(convertByWidthRatio(231))
        }
        
        reviewContainer.addSubview(profileImage)
        profileImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(convertByWidthRatio(20))
            $0.leading.equalToSuperview().inset(convertByWidthRatio(25))
            $0.size.equalTo(convertByWidthRatio(20))
        }
        
        reviewContainer.addSubview(userNicknameLabel)
        userNicknameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImage)
            $0.leading.equalTo(profileImage.snp.trailing).offset(convertByWidthRatio(7))
            $0.trailing.equalToSuperview().inset(convertByWidthRatio(150))
            $0.width.equalTo(125)
            $0.height.equalTo(19)
        }
        
        reviewContainer.addSubview(reviewDateLabel)
        reviewDateLabel.snp.makeConstraints {
            $0.centerY.equalTo(userNicknameLabel)
            $0.leading.equalToSuperview().inset(convertByWidthRatio(201))
            $0.trailing.equalToSuperview().inset(convertByWidthRatio(59))
            $0.width.equalTo(67)
            $0.height.equalTo(17)
        }
        
        reviewContainer.addSubview(reportLabel)
        reportLabel.snp.makeConstraints {
            $0.centerY.equalTo(userNicknameLabel)
            $0.leading.equalToSuperview().inset(convertByWidthRatio(279))
            $0.trailing.equalToSuperview().inset(convertByWidthRatio(25))
            $0.width.equalTo(23)
            $0.height.equalTo(17)
        }
        
        reviewContainer.addSubview(reviewCategoryStackView)
        reviewCategoryStackView.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(convertByWidthRatio(10))
            $0.leading.equalTo(profileImage)
        }
        
        reviewContainer.addSubview(reviewTextLabel)
        reviewTextLabel.snp.makeConstraints {
            $0.top.equalTo(reviewCategoryStackView.snp.bottom).offset(convertByWidthRatio(16))
            $0.directionalHorizontalEdges.equalToSuperview().inset(25)
            $0.width.equalTo(convertByWidthRatio(277))
            $0.height.equalTo(convertByWidthRatio(120))
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
        
        reportLabel.do {
            $0.basic(text: "신고", font: .captionM1!, color: .gbbGray300!)
        }
        
        reviewTextLabel.do {
            $0.basic(font: .subHead!, color: .gbbGray400!)
            $0.numberOfLines = 6
        }
    }
    
    // MARK: - Custom Method
    
    func configureCellUI(_ data: ReviewList, _ labelHeight: CGFloat) {
        
        userNicknameLabel.text = data.memberNickname
        reviewDateLabel.text = data.createdAt
        reviewTextLabel.text = data.reviewText
        
        if !data.recommendKeywordList.isEmpty {
            
            let list = data.recommendKeywordList.map {
                $0.recommendKeywordID
            }
            reviewCategoryStackView.getChipStatus(list)
            
            reviewContainer.snp.remakeConstraints {
                $0.top.equalToSuperview()
                $0.directionalHorizontalEdges.equalToSuperview().inset(convertByWidthRatio(24))
                $0.width.equalTo(convertByWidthRatio(327))
                $0.height.equalTo(convertByWidthRatio(labelHeight + 111))
            }
            
            reviewTextLabel.snp.remakeConstraints {
                $0.top.equalTo(reviewCategoryStackView.snp.bottom).offset(convertByWidthRatio(16))
                $0.directionalHorizontalEdges.equalToSuperview().inset(25)
                $0.width.equalTo(convertByWidthRatio(277))
                $0.height.equalTo(convertByWidthRatio(labelHeight))
            }
        } else {
            reviewCategoryStackView.getNoRecommend()
            
            reviewContainer.snp.remakeConstraints {
                $0.top.equalToSuperview()
                $0.directionalHorizontalEdges.equalToSuperview().inset(convertByWidthRatio(24))
                $0.width.equalTo(convertByWidthRatio(327))
                $0.height.equalTo(convertByWidthRatio(labelHeight + 70))
            }
            
            reviewTextLabel.snp.remakeConstraints {
                $0.top.equalTo(profileImage.snp.bottom).offset(convertByWidthRatio(10))
                $0.directionalHorizontalEdges.equalToSuperview().inset(25)
                $0.width.equalTo(convertByWidthRatio(277))
                $0.height.equalTo(convertByWidthRatio(labelHeight))
            }
        }
    }
}
