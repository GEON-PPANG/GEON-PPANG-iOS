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
    
    private let leftEmptyView = UIView()
    private lazy var reviewProgressBarStackView = ReviewProgressBarStackView()
    private let rightEmptyView = UIView()
    
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
        
        contentView.addSubviews(leftEmptyView, reviewProgressBarStackView, rightEmptyView)
        
        leftEmptyView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(33.5)
            $0.height.equalTo(157)
        }
        
        rightEmptyView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.width.equalTo(33.5)
            $0.height.equalTo(157)
        }
        
        reviewProgressBarStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(33.5)
            $0.height.equalTo(157)
        }
    }
    
    private func setUI() {
        
        [leftEmptyView, rightEmptyView].forEach {
            $0.backgroundColor = .gbbWhite
        }
    }
    
    func updateUI(_ data: WrittenReviewsResponseDTO) {
        
        reviewProgressBarStackView.updateGauge(data.tastePercent, data.specialPercent, data.kindPercent, data.zeroPercent)
        
        print(data)
    }
}
