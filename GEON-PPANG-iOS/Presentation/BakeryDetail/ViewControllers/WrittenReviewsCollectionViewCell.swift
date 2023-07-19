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
    
    private let profileImage = UIImageView()
    private let userNicknameLabel = UILabel() // 서버
    private let reviewDateLabel = UILabel() // 서버
    private let reportLabel = UILabel()
    private lazy var reviewCategoryStackView = ReviewCategoryStackView() // 서버
    private let reviewTextLabel = UILabel() // 서버
    
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
        
        profileImage.do {
            $0.image = .logoIcon20px
            $0.contentMode = .scaleToFill
        }
        
        userNicknameLabel.do {
            $0.basic(font: .bodyB2!, color: .gbbMain1!)
            $0.text = "보연티비ㅇㅇㅇㅇㅇㅇ"
        }
        
        reviewDateLabel.do {
            $0.basic(font: .captionM1!, color: .gbbGray400!)
            $0.text = "23.08.09"
            $0.textAlignment = .right
        }
        
        reportLabel.do {
            $0.basic(text: "신고", font: .captionM1!, color: .gbbGray300!)
        }
        
        reviewTextLabel.do {
            $0.basic(font: .subHead!, color: .gbbGray400!)
            $0.text = "여기 소금빵 미친 존맛탱임 우리 건빵 가족들에게도 알려주고싶은 맛이에용앙아아아아아아아아아아아ㅏㅇ아ㅏ아아아아아아아아아ㅏ아아"
            $0.numberOfLines = 3
        }
    }
    
    private func setLayout() {
        
        contentView.addSubviews(profileImage, userNicknameLabel, reviewDateLabel, reportLabel, reviewCategoryStackView, reviewTextLabel)
        
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
            $0.leading.equalToSuperview().inset(279)
            $0.trailing.equalToSuperview().inset(25)
            $0.width.equalTo(23)
            $0.height.equalTo(17)
        }
        
        reviewCategoryStackView.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(15)
            $0.leading.equalTo(profileImage)
        }
        
        reviewTextLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(94)
            $0.directionalHorizontalEdges.equalTo(25)
            $0.width.equalTo(277)
            $0.height.equalTo(60)
        }
    }
}
