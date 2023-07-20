//
//  ReviewCategoryCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/17.
//

import UIKit

import SnapKit
import Then

final class ReviewCategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private lazy var reviewProgressBarStackView = ReviewProgressBarStackView() // 서버
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        contentView.addSubview(reviewProgressBarStackView)
        
        reviewProgressBarStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(33.5)
            $0.height.equalTo(134)
        }
    }
    
    func updateUI(_ data: WrittenReviewsResponseDTO) {
        
        reviewProgressBarStackView.updateGauge(data.tastePercent, data.specialPercent, data.kindPercent, data.zeroPercent)
        
        print(data)
    }
}
