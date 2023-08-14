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
    private let signIntype: SignInPropetyType = .email

    // MARK: - UI Property
    
    private lazy var securityButton = UIButton()
    private let emptyView = UIView()
    private let rightStackView = UIStackView()

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
        
        rightStackView.snp.makeConstraints {
            $0.width.equalTo(42)
            $0.height.equalTo(24)
        }
        
        emptyView.snp.makeConstraints {
            $0.width.equalTo(18)
        }
        
        securityButton.snp.makeConstraints {
            $0.size.equalTo(24)
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.backgroundColor = .gbbBackground2
            $0.makeCornerRound(radius: 10)
            $0.makeBorder(width: 1, color: .clear)
            $0.contentVerticalAlignment = .center
            $0.setLeftPadding(amount: 18)
            $0.setPlaceholder(color: .gbbGray300!, font: .headLine!)
            $0.rightViewMode = .always

        }
        
        rightStackView.do {
            $0.addArrangedSubviews(securityButton, emptyView)
        }
        
        securityButton.do {
            $0.setImage(.hideIcon, for: .normal)
            $0.setImage(.showIcon, for: .selected)
            $0.addAction(UIAction { [weak self]_ in
                self?.isSecureTextEntry.toggle()
                self?.securityButton.isSelected.toggle()
            }, for: .touchUpInside)
        }
    }
    
    func configureViewType(_ viewType: SignInPropetyType) {
        
        switch viewType {
        case .checkPassword, .password:
            self.isSecureTextEntry = true
            self.rightView = rightStackView
        default:
            self.rightView = .none
        }
    }
        
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets(top: topPadding,
                                           left: 0,
                                           bottom: 0,
                                           right: 0))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets(top: topPadding,
                                           left: 0,
                                           bottom: 0,
                                           right: 0))
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets(top: topPadding,
                                           left: 0,
                                           bottom: 0,
                                           right: 0))
    }
    
    override public func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.rightViewRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets(top: topPadding - 5,
                                           left: 0,
                                           bottom: 0,
                                           right: 0))
    }
}
