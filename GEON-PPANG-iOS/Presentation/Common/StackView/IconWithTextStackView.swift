//
//  CountStackView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/08/21.
//

import UIKit

import SnapKit
import Then

enum HomeIconType {
    case reviews, bookmark
    
    var icon: UIImage {
        switch self {
        case .reviews: return .reviewIcon16px400
        case .bookmark: return .bookmarkIcon16px400
        }
    }
}

final class IconWithTextStackView: UIStackView {
    
    // MARK: - Property
    
    private var iconType: HomeIconType = .bookmark
    
    // MARK: - UI Property
    
    private let icon = UIImageView()
    private let countLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.addArrangedSubviews(icon, countLabel)
        
        icon.snp.makeConstraints {
            $0.size.equalTo(16)
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.spacing = 1
            $0.axis = .horizontal
        }
        
    }
    
    func iconViewType(_ type: HomeIconType, count: Int) {
        
        icon.image = type.icon
        countLabel.basic(text: "(\(count))",
                         font: .captionB1!,
                         color: .gbbGray400!)
    }
    
}
