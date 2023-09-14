//
//  SignInTextField.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class SignInTextField: UITextField {
    
    // MARK: - Property
    
    private let signIntype: SignInPropertyType = .email
    var tappedCheckButton: (() -> Void)?
    
    // MARK: - UI Property
    
    private lazy var securityButton = UIButton()
    private lazy var checkButton = UIButton()
    
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
        
        checkButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 70, height: 25))
        }
        
        securityButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 24, height: 34))
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.autocorrectionType = .no
            $0.backgroundColor = .gbbBackground2
            $0.contentVerticalAlignment = .center
            $0.rightViewMode = .always
            
            $0.makeCornerRound(radius: 10)
            $0.makeBorder(width: 1, color: .clear)
            $0.setPlaceholder(color: .gbbGray300!, font: .headLine!)
        }
    }
    
    private func configureSecurityButton() {
        
        self.do {
            $0.isSecureTextEntry = true
            $0.rightView = securityButton
            $0.textContentType = .oneTimeCode
            
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
    
    private func configureDuplicatedButton() {
        
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .gbbMain3
        configuration.baseForegroundColor = .gbbWhite
        configuration.cornerStyle = .capsule
        configuration.attributedTitle = AttributedString("중복확인",
                                                         attributes: AttributeContainer([.font: UIFont.captionM1!]))
        configuration.contentInsets = .init(top: 10,
                                            leading: 10,
                                            bottom: 10,
                                            trailing: 10)
        
        self.do {
            $0.rightView = checkButton
        }
        
        checkButton.do {
            $0.configuration = configuration
            $0.addAction(UIAction { [weak self] _ in
                guard let self else { return }
                self.tappedCheckButton?()
            }, for: .touchUpInside)
        }
    }
    
    func configureViewType(_ viewType: SignInPropertyType) {
        
        self.placeholder = viewType.placeHolder
        
        switch viewType {
        case .checkPassword, .password, .loginPassword:
            configureSecurityButton()
        case .email:
            configureDuplicatedButton()
        default:
            self.rightView = .none
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets(top: 15,
                                           left: 18,
                                           bottom: 0,
                                           right: 25))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets(top: 15,
                                           left: 18,
                                           bottom: 0,
                                           right: 25))
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets(top: 15,
                                           left: 18,
                                           bottom: 0,
                                           right: 25))
    }
    
    override public func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.rightViewRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets(top: 10,
                                           left: -18,
                                           bottom: 0,
                                           right: 18))
    }
}
