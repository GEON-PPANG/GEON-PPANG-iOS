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
        
        setUI()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        
        self.backgroundColor = .gbbWhite
        
        reviewContainer.do {
            $0.backgroundColor = .gbbBackground2
            $0.makeCornerRound(radius: 12)
        }
        
        profileImage.do {
            $0.image = .logoIcon20px
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
            $0.numberOfLines = 3
            $0.adjustsFontSizeToFitWidth = true
        }
    }
    
    private func setLayout() {
        
        contentView.addSubview(reviewContainer)
        reviewContainer.addSubviews(profileImage, userNicknameLabel, reviewDateLabel, reportLabel, reviewCategoryStackView, reviewTextLabel)
        
        reviewContainer.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.width.equalTo(327)
            $0.height.equalTo(174)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(25)
            $0.size.equalTo(20) // 기기대응 생각하기
        }
        
        userNicknameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImage)
            $0.leading.equalToSuperview().inset(52)
            $0.trailing.equalToSuperview().inset(150)
            $0.width.equalTo(125)
            $0.height.equalTo(19)
        }
        
        reviewDateLabel.snp.makeConstraints {
            $0.centerY.equalTo(userNicknameLabel)
            $0.leading.equalToSuperview().inset(201)
            $0.trailing.equalToSuperview().inset(59)
            $0.width.equalTo(67)
            $0.height.equalTo(17)
        }
        
        reportLabel.snp.makeConstraints {
            $0.centerY.equalTo(userNicknameLabel)
            $0.leading.equalToSuperview().inset(convertByWidthRatio(279))
            $0.trailing.equalToSuperview().inset(convertByWidthRatio(25))
            $0.width.equalTo(23)
            $0.height.equalTo(17)
        }
        
        reviewCategoryStackView.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(15)
            $0.leading.equalTo(profileImage)
        }
        
        reviewTextLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(94)
            $0.directionalHorizontalEdges.equalToSuperview().inset(25)
            $0.width.equalTo(277)
            $0.height.equalTo(60)
        }
    }
    
    func updateUI(_ data: ReviewList) {
        
        userNicknameLabel.text = data.memberNickname
        reviewDateLabel.text = data.createdAt
        reviewTextLabel.text = data.reviewText
        
        if data.recommendKeywordList.isEmpty {
            
        } else {
            let list = data.recommendKeywordList.map {
                $0.recommendKeywordID
            }
            reviewCategoryStackView.getChipStatus(list)
        }
    }
}
