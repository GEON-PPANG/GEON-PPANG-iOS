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
    private lazy var reviewCategoryStackView = ReviewCategoryStackView() //서버
    private let reviewTextLabel = UILabel() // 서버
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        
        profileImage.do {
            $0.image = .logoIcon16px
        }
    }
    
    private func setLayout() {
        
    }
}
