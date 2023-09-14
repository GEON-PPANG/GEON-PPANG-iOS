//
//  LoginTextFiledView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class CommonTextView: UIView {
    
    // MARK: - Property
    
    var tappedCheckButton: (() -> Void)?
    var delegate: UITextFieldDelegate? {
        didSet {
            setDelegate()
        }
    }
    
    // MARK: - UI Property
    
    private let commonTextField = SignInTextField()
    private let titleLabel = UILabel()
    private let checkLabel = UILabel()
    var password: String = ""
    
    // MARK: - Life Cycle
    
    init(_ type: SignInPropertyType) {
        super.init(frame: .zero)
        
        setLayout()
        setUI(type: type)
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.addSubview(commonTextField)
        commonTextField.snp.makeConstraints {
            
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(74)
        }
        
        self.addSubview(checkLabel)
        checkLabel.snp.makeConstraints {
            $0.top.equalTo(commonTextField.snp.bottom).offset(7)
            $0.trailing.equalToSuperview()
        }
        
        commonTextField.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalToSuperview().offset(18)
        }
    }
    
    private func setUI(type: SignInPropertyType) {
        
        titleLabel.do {
            $0.basic(font: .bodyB2!, color: .gbbGray400!)
            $0.text = type.title
        }
        
        checkLabel.do {
            $0.font = .captionM1
        }
        
        commonTextField.do {
            $0.configureViewType(type)
            $0.tappedCheckButton = {
                self.tappedCheckButton?()
            }
        }
    }
    
    func setDelegate() {
        
        commonTextField.delegate = self.delegate
    }
    
    func fetchText() -> String {
        return commonTextField.text ?? ""
    }
    
    func configureTextField() -> SignInTextField {
        return commonTextField
    }
    
    func setErrorMessage(_ message: String, _ isValid: Bool) {
        
        titleLabel.textColor = isValid ? .gbbError: .gbbMain3
        checkLabel.basic(text: message,
                         font: .captionM1!,
                         color: isValid ? .gbbError!: .gbbMain3!)
        commonTextField.layer.borderColor = isValid ? UIColor.gbbError?.cgColor : UIColor.gbbMain3?.cgColor
    }
    
    func clearErrorMessage() {
        
        titleLabel.textColor = .gbbGray400
        checkLabel.text = ""
        commonTextField.layer.borderColor = UIColor.clear.cgColor
    }
}
