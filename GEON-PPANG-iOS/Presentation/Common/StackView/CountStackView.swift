//
//  CountStackView.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/17.
//

import UIKit

import SnapKit
import Then

enum CountType {
    case bookmark
    case review
}
//let label = CountStackView(type: .bookmark)
final class CountStackView: UIStackView {

    // MARK: - Property
    
    private let countType: CountType
    private var icon: UIImage {
        switch countType {
        case .bookmark:
            return .bookmarkIcon16px
        case .review:
            return .reviewIcon16px
        }
    }
    private var count: UInt16 = 18
    
    // MARK: - UI Property
    
    private lazy var countIcon = UIImageView(image: icon)
    private lazy var countLabel = UILabel()
    
    // MARK: - Initializer
    
    init(type: CountType) {
        self.countType = type
        
        super.init(frame: .zero)
        
        setUI()
        setLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        
        self.do {
            $0.axis = .horizontal
            $0.spacing = 1
            $0.distribution = .equalSpacing
        }
        
        countLabel.do {
            $0.basic(text: "(\(count))", font: .captionB1!, color: .gbbGray300!)
            $0.frame.size = $0.sizeThatFits(self.frame.size)
        }
    }
    
    private func setLayout() {
        
        self.addArrangedSubviews(countIcon, countLabel)
        
        countIcon.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.top.leading.equalToSuperview().inset(0.5)
        }
        
        countLabel.snp.makeConstraints {
            $0.height.equalTo(17)
            $0.top.equalToSuperview()
            $0.leading.equalTo(countIcon.snp.trailing).offset(1)
        }
    }
}
