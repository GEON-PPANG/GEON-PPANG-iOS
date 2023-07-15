//
//  SignInTextField.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/15.
//

import UIKit

import SnapKit
import Then

class SignInTextField: UITextField {
    
    // MARK: - Property
    
    private let topPadding: CGFloat = 15

    // MARK: - UI Property
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        self.do {
            $0.backgroundColor = .gbbBackground2
            $0.makeCornerRound(radius: 10)
            $0.makeBorder(width: 1, color: .clear)
            $0.contentVerticalAlignment = .center
            $0.setLeftPadding(amount: 18)
            $0.setPlaceholder(color: .gbbGray300!, font: .headLine!)
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets(top: topPadding, left: 0, bottom: 0, right: 0))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets(top: topPadding, left: 0, bottom: 0, right: 0))
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets(top: topPadding, left: 0, bottom: 0, right: 0))
    }
}
