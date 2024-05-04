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
    
    case reviews, bookmark, region
    
    var icon: UIImage {
        switch self {
        case .reviews: return .Icon.Review.px16gray400
        case .bookmark: return .Icon.Bookmark.px16gray400
        case .region: return .Icon.map
        }
    }
    
    var spacing: CGFloat {
        switch self {
        case .reviews, .bookmark: return 1
        case .region: return 6
        }
    }
}

final class IconWithTextView: UIButton {
    
    // MARK: - Property
    
    private var iconType: HomeIconType = .bookmark
    
    // MARK: - Life Cycle
    
    init (_ type: HomeIconType) {
        super.init(frame: .zero)
        
        setUI(type: type)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI(type: HomeIconType) {
        
        var config = UIButton.Configuration.plain()
        config.image = type.icon
        config.imagePadding = type.spacing
        config.contentInsets = .zero
        config.baseBackgroundColor = .clear
        
        self.do {
            $0.configuration = config
        }
    }
    
    func configureListUI(text: String) {
        
        self.configuration?.attributedTitle = AttributedString(text, attributes: AttributeContainer([.font: UIFont.captionM1, .foregroundColor: UIColor.gbbGray400]))
        
    }
    
    func configureHomeCell(count: Int) {
        
        self.configuration?.attributedTitle = AttributedString("(\(count))", attributes: AttributeContainer([.font: UIFont.captionB1, .foregroundColor: UIColor.gbbGray400]))
    }
}
