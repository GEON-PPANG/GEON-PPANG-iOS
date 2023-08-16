//
//  LoginTextFiledView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/14.
//

import UIKit

import SnapKit
import Then

enum SignInPropetyType: String, CaseIterable {
    
    case email = "이메일"
    case password = "비밀번호"
    case checkPassword = "비밀번호 재확인"
    case nickname = "닉네임"
    
    var placeHolder: String {
        switch self {
        case .email: return  "이메일을 입력해주세요"
        case .password: return "영문, 숫자 포함 8자리이상"
        case .checkPassword: return "비밀번호를 재입력해주세요"
        case .nickname: return "닉네임 10자 이내, 특수문자 금지"
        }
    }
}

final class CommonTextView: UIView {
    
    // MARK: - Property
    
    private var signInType: SignInPropetyType = .email {
        didSet {
            setUI()
        }
    }
    
    var isValid: Bool = false
    var validCheck: ((Bool) -> Void)?
    var invalidCheck: ((Bool) -> Void)?
    var duplicatedCheck: ((String) -> Void)?
    var textFieldData: ((String) -> Void)?
    var changeLayout: (() -> Void)?
    
    // MARK: - UI Property
    
    private let commonTextField = SignInTextField()
    private let titleLabel = UILabel()
    private let checkLabel = UILabel()
    var password: String = ""
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
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
    
    private func setUI() {
        
        titleLabel.do {
            $0.basic(font: .bodyB2!, color: .gbbGray400!)
            $0.text = signInType.rawValue
        }
        
        checkLabel.do {
            $0.font = .captionM1
        }
    }
    
    func cofigureSignInType(_ type: SignInPropetyType) {
        
        self.signInType = type
        commonTextField.configureViewType(type)
    }
    
    private func setDelegate() {
        
        commonTextField.delegate = self
    }
    
    func fetchText() -> String {
        
        return commonTextField.text ?? ""
    }
}

// MARK: - UITextFieldDelegate

extension CommonTextView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        if text.isEmpty {
            self.validCheck?(false)
            textField.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        switch signInType {
        case .email:
            if !text.isValidEmail() {
                setErrorMessage("올바른 이메일을 입력해주세요.")
            } else {
                clearErrorMessage(true)
            }
        case .password:
            if !text.isContainNumberAndAlphabet() && text.count < 8 {
                setErrorMessage("영문, 숫자 포함 8자리 이상")
            } else {
                clearErrorMessage(true)
            }
        case .nickname:
            if !text.isNotContainSpecialCharacters() {
                setErrorMessage("10자 이내, 특수문자 금지")
            } else {
                clearErrorMessage(true)
            }
        case .checkPassword:
            self.textFieldData?(fetchText())
        }
        
        if text.isEmpty {
            clearErrorMessage(false)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let currentText = textField.text else { return false }
        let changedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if signInType == .nickname {
            return changedText.count < 11
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        duplicatedCheck?(fetchText())
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        duplicatedCheck?(fetchText())
        self.changeLayout?()
        textField.resignFirstResponder()
        return true
    }
    
    func setErrorMessage(_ message: String) {
        
        self.validCheck?(false)
        titleLabel.textColor = .gbbError
        checkLabel.basic(text: message,
                         font: .captionM1!,
                         color: .gbbError!)
        commonTextField.layer.borderColor = UIColor.gbbError?.cgColor
    }
    
    func clearErrorMessage(_ isValid: Bool) {
        
        self.validCheck?(isValid)
        titleLabel.textColor = .gbbGray400
        checkLabel.text = ""
        commonTextField.layer.borderColor = UIColor.clear.cgColor
    }
}
