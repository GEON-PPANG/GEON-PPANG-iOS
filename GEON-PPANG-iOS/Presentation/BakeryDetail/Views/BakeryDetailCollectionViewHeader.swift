//
//  BakeryDetailCollectionViewHeader.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/19.
//

import UIKit

import SnapKit
import Then

final class BakeryDetailCollectionViewHeader: UICollectionReusableView {
        
    // MARK: - UI Property
    
    private let titleLabel = UILabel()
    private let subTitleStackView = IconLabelStackView(type: .notice)
    private lazy var reviewSortButton = ReviewSortButton()
    
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
        
        titleLabel.do {
            $0.basic(text: "가게 상세정보", font: .bodyB1!, color: .gbbBlack!) // 임시 텍스트
            $0.frame.size = $0.sizeThatFits(self.frame.size)
        }
        
        subTitleStackView.do {
            $0.spacing = 4
        }
    }
    
    private func setLayout() {
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
            $0.height.equalTo(22)
        }
        
        subTitleStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(7.5)
            $0.leading.equalTo(titleLabel).offset(0.5)
        }
    }
    
    // MARK: - Custom Method
    
    func configureSubTitle() {
        
        self.addSubview(subTitleStackView)
    }
    
    func configurereviewSortButton() {
        
        self.addSubview(reviewSortButton)
    }
}
