//
//  BookmarkButton.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class BookmarkButton: UIButton {
    
    var updateData: ((Bool) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
        action()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
        var configuration =  UIButton.Configuration.plain()
        configuration.baseBackgroundColor = .clear
        
        self.do {
            $0.tintColor = .clear
            $0.configuration = configuration
            $0.configurationUpdateHandler = { button in
                switch button.state {
                case .selected:
                    button.configuration?.image = .enabledBookmarkButton
                    button.configuration?.baseForegroundColor = .gbbPoint1
                    
                default:
                    button.configuration?.image = .disabledBookmarkButton
                    button.configuration?.baseForegroundColor = .gbbGray300
                }
            }
        }
    }
    
    private func action() {
        self.addAction(UIAction { _ in
            self.updateData?(self.isSelected)
            self.isSelected.toggle()
            self.setUI()
        }, for: .touchUpInside)
    }
    
    func getCount(_ count: Int) {
        if count == 0 {
            configuration?.title = ""
        } else {
            configuration?.attributedTitle = AttributedString("\(count)명", attributes: AttributeContainer([.font: UIFont.pretendardBold(14)]))
        }
    }
}
