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
    case reviews, bookmark, list
    
    var icon: UIImage {
        switch self {
        case .reviews: return .reviewIcon16px400
        case .bookmark: return .bookmarkIcon16px400
        case .list: return .mapIcon
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
    
    init (_ type: HomeIconType) {
        super.init(frame: .zero)
        
        setLayout()
        setUI(type: type)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.addArrangedSubviews(icon, countLabel)
        
        icon.snp.makeConstraints {
            $0.size.equalTo(15)
        }
    }
    
    private func setUI(type: HomeIconType) {
        
        self.do {
            $0.spacing = iconType == .list ? 6 : 1
            $0.axis = .horizontal
        }
        
        icon.do {
            $0.image = type.icon
        }
    }
    
    func configureListUI(text: String) {
        
        countLabel.basic(text: text,
                         font: .captionB1!,
                         color: .gbbGray400!)
    }
    
    func configureHomeCell(count: Int) {
        
        countLabel.basic(text: "(\(count))",
                         font: .captionB1!,
                         color: .gbbGray400!)
    }
}
