//
//  MyReviewsHeaderView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MyReviewsHeaderView: UICollectionReusableView {
    
    // MARK: - UI Property
    
    private let dateLabel = UILabel()
    private lazy var dotButton = UIButton()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        addSubviews(dateLabel, dotButton)
        
        dateLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        dotButton.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-19)
        }
    }
    
    private func setUI() {
        
        dateLabel.do {
            $0.basic(font: .pretendardMedium(13), color: .gbbGray400!)
        }
        
        dotButton.do {
            $0.setImage(.dotdotdotIcon, for: .normal)
        }
    }
}
