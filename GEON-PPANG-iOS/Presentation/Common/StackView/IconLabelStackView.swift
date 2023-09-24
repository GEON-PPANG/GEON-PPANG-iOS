//
//  IconLabelStackView.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/17.
//

import UIKit

import SnapKit
import Then

enum IconType {
    case bookmark
    case review
    case notice
    case basic
}

final class IconLabelStackView: UIStackView {
    
    // MARK: - Property
    
    private let iconType: IconType
    private var ic: UIImage {
        switch iconType {
        case .bookmark:
            return .bookmarkIcon16px300
        case .review:
            return .reviewIcon16px
        case .notice:
            return .noticeIcon18px
        case .basic:
            return .swapIcon
        }
    }
    private var icSize: Int {
        switch iconType {
        case .bookmark, .review, .basic:
            return 16
        case .notice:
            return 18
        }
    }
    
    private var count: Int = 0 {
        didSet {
            label.text = labelText
        }
    }
    
    private var labelText: String {
        switch iconType {
        case .bookmark, .review:
            return "(\(count))"
        case .notice:
            return "웹사이트에 성분정보가 있어요!"
        case .basic:
            return "기본순"
        }
    }
    private var labelFont: UIFont {
        switch iconType {
        case .bookmark, .review, .basic:
            return .captionB1!
        case .notice:
            return .captionM1!
        }
    }
    private var labelColor: UIColor {
        switch iconType {
        case .bookmark, .review, .notice:
            return .gbbGray300!
        case .basic:
            return .gbbBlack!
        }
    }
    
    // MARK: - UI Property
    
    private lazy var icon = UIImageView(image: ic)
    private lazy var label = UILabel()
    
    // MARK: - Initializer
    
    init(type: IconType) {
        self.iconType = type
        
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.addArrangedSubview(icon)
        icon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(self.iconType == .notice ? 0 : 0.5)
            $0.leading.equalToSuperview()
            $0.size.equalTo(icSize)
        }
        
        self.addArrangedSubview(label)
        label.snp.makeConstraints {
            $0.centerY.equalTo(icon)
            $0.height.equalTo(17)
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.axis = .horizontal
            $0.spacing = 1
            $0.distribution = .equalSpacing
        }
        
        icon.do {
            $0.contentMode = .scaleAspectFit
        }
        
        label.do {
            $0.basic(text: labelText, font: labelFont, color: labelColor)
            $0.frame.size = $0.sizeThatFits(self.frame.size)
        }
    }
    
    // MARK: - Custom Method
    
    func getCount(_ count: Int) {
        
        self.count = count
    }
}
