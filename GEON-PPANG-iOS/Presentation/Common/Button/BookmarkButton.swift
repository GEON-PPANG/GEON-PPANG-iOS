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
    
    // MARK: - Property
    
    var tappedBookmarkButton: ((Bool) -> Void)?
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
        addActionToBookmarkButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
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
    
    private func addActionToBookmarkButton() {
        
        self.addAction(UIAction { _ in
            self.tappedBookmarkButton?(self.isSelected)
            self.isSelected.toggle()
            self.setUI()
        }, for: .touchUpInside)
    }
    
    func configureButtonTitle(_ count: Int) {
        
        if count == 0 {
            configuration?.title = ""
        } else {
            configuration?.attributedTitle = AttributedString("\(count)명", attributes: AttributeContainer([.font: UIFont.bodyB2!]))
        }
    }
}
