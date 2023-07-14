//
//  LoginTextFiledView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/14.
//

import UIKit

import SnapKit
import Then

enum LogoinPropetyType: String {
    case email = "이메일"
    case password = "비밀번호"
    case checkPasswaord = "비밀번호 재확인"
    case nickname = "닉네임"
}

final class LoginTextFiledView: UIView {
    
    private let loginType: LogoinPropetyType = .password
    
    private let commonTextField = UITextField()
    private let titleLabel = UILabel()
    private let checkLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
        
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        commonTextField.do {
            $0.backgroundColor = .gbbBackground2
            $0.makeCornerRound(radius: 10)
            $0.contentVerticalAlignment = .center
            $0.setLeftPadding(amount: 18)
            $0.setPlaceholder(color: .gbbGray300!, font: .headLine!)
        }
        
        titleLabel.do {
            $0.basic(font: .bodyB2!, color: .gbbGray400!)
            $0.text = loginType.rawValue
        }
        
        checkLabel.do {
            $0.font = .captionM1
        }
    }
    
    private func setUI() {
        addSubviews(commonTextField, checkLabel)
        commonTextField.addSubview(titleLabel)
        
        commonTextField.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(74)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalToSuperview().offset(18)
        }
        
        checkLabel.snp.makeConstraints {
            $0.top.equalTo(commonTextField.snp.bottom).offset(7)
            $0.trailing.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        commonTextField.delegate = self
    }
    
}

extension LoginTextFiledView: UITextFieldDelegate {
    func textField(_ textField: UITextField, textRectForBounds bounds: CGRect) -> CGRect {
        let newY: CGFloat = 20.0
        let modifiedBounds = CGRect(x: bounds.origin.x, y: bounds.origin.y + newY, width: bounds.size.width, height: bounds.size.height)
        return modifiedBounds
    }    
 // 입력이 시작되면 호출
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isEmpty {
            textField.layer.borderColor = UIColor.clear.cgColor
        } else {
            if !textField.text!.isValidEmail() {
                textField.layer.borderColor = UIColor.gbbError?.cgColor
            }
            switch loginType {
            case .email:
                if !textField.text!.isValidEmail() {
                    textField.layer.borderColor = UIColor.gbbError?.cgColor
                }
            case .password:
                if !textField.text!.isContainNumberAndAlphabet() {
                    textField.layer.borderColor = UIColor.gbbError?.cgColor
                }
            case .nickname:
                if !textField.text!.isNotContainSpecialCharacters() {
                    textField.layer.borderColor = UIColor.gbbError?.cgColor
                }
            case .checkPasswaord:
                return
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.clear.cgColor
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        switch loginType {
        case .email:
            if !text.isValidEmail() {
                titleLabel.textColor = .gbbError!
                checkLabel.basic(text: "올바른 이메일을 입력해주세요.",
                                 font: .captionM1!, color: .gbbError!)
                textField.layer.borderColor = UIColor.gbbError?.cgColor
            } else {
                titleLabel.textColor = .gbbGray400!
                checkLabel.text = ""
                textField.layer.borderColor = UIColor.clear.cgColor
            }
        case .password:
            if !text.isContainNumberAndAlphabet() {
                titleLabel.textColor = .gbbError!
                checkLabel.basic(text: "영문, 숫자 포함 8자리 이상",
                                 font: .captionM1!, color: .gbbError!)
                textField.layer.borderColor = UIColor.gbbError?.cgColor
            } else {
                titleLabel.textColor = .gbbGray400!
                checkLabel.text = ""
                textField.layer.borderColor = UIColor.clear.cgColor
            }
        case .nickname:
            if !text.isNotContainSpecialCharacters() {
                titleLabel.textColor = .gbbError!
                checkLabel.basic(text: "10자이내, 특수문자 금지",
                                 font: .captionM1!, color: .gbbError!)
                titleLabel.textColor = .gbbError!
                textField.layer.borderColor = UIColor.gbbError?.cgColor
            } else {
                titleLabel.textColor = .gbbGray400!
                checkLabel.text = ""
                textField.layer.borderColor = UIColor.clear.cgColor
            }
        case .checkPasswaord:
            print("check password")
        }
        if text.isEmpty {
            titleLabel.textColor = .gbbGray400!
            checkLabel.text = ""
            textField.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changeText = currentText.replacingCharacters(in: stringRange, with: string)
        if loginType == .nickname {
            return changeText.count < 11
        }
        print(changeText.count)
       
        return true
    }
    // 엔터를 누르면 return이 먼저 호출되고 입력~가 호출됨.
    // 엔터키가 눌러졌을 때 호출 -> 이거 사용해야함
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return")
        textField.resignFirstResponder()
        return true
    }
    
    // 입력이 끝날 때 호출
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("입력을 마쳤습니다")
        return true
    }
    
}
