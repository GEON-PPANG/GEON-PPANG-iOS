//
//  NickNameViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class NickNameViewController: BaseViewController {
    
    // MARK: - Property
    
    var email: String = ""
    var password: String = ""
    private var checkNickname: String = ""
    private var isValid: Bool = false {
        didSet {
            configureCheckButtonUI(isValid)
        }
    }
    
    // MARK: - UI Property
    
    private let naviView = CustomNavigationBar()
    private let titleLabel = UILabel()
    private let nicknameTextField = CommonTextView(.nickname)
    private lazy var checkButton = CommonButton()
    private lazy var nextButton = CommonButton()
    private lazy var backGroundView = BottomSheetAppearView()
    private lazy var bottomSheet = CommonBottomSheet()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setKeyboardHideGesture()
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        
        view.addSubview(naviView)
        naviView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview()
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(24)
        }
        
        view.addSubview(nicknameTextField)
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(74)
        }
        
        view.addSubview(checkButton)
        checkButton.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(29)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(CGFloat().heightConsideringBottomSafeArea(54))
        }
        
        [checkButton, nextButton].forEach {
            $0.snp.makeConstraints {
                $0.directionalHorizontalEdges.equalToSuperview().inset(24)
                $0.height.equalTo(56)
            }
        }
    }
    
    override func setUI() {
        
        naviView.do {
            $0.configureBottomLine()
            $0.configureBackButtonAction(UIAction { _ in
                self.navigationController?.popViewController(animated: true)
            })
        }
        
        titleLabel.do {
            $0.numberOfLines = 0
            $0.basic(text: I18N.Nickname.title,
                     font: .title1!,
                     color: .gbbGray700!)
        }
        
        checkButton.do {
            $0.configureButtonUI(.clear)
            $0.configureBorder(1, .gbbGray300)
            $0.configureButtonTitle(.duplicate)
            $0.addActionToCommonButton {
                self.postNicknameCheck()
            }
        }
        
        nicknameTextField.do {
            $0.delegate = self
        }
        
        nextButton.do {
            $0.isUserInteractionEnabled = false
            $0.configureButtonUI(.gbbGray200!)
            $0.configureButtonTitle(.next)
        }
        
        bottomSheet.do {
            $0.dismissBottomSheet = {
                self.backGroundView.dissmissFromSuperview()
            }
        }
    }
    
    func configureCheckButtonUI(_ isValid: Bool) {
        
        self.checkButton.do {
            $0.isEnabled = isValid
            $0.configureButtonUI(.clear)
            $0.configureBorder(isValid ? 2 : 1, isValid ? .gbbMain2! : .gbbGray300!)
        }
    }
    
    func configureNextButtonUI(_ isValid: Bool) {
        
        self.nextButton.do {
            $0.isUserInteractionEnabled = isValid
            $0.configureButtonTitle(isValid ? .start : .next)
            $0.configureButtonUI(isValid ? .gbbMain2! : .gbbGray200!)
            $0.tappedCommonButton = {
                Utils.push(self.navigationController, FilterViewController(isInitial: true))
            }
        }
    }
    
    func configureBottomSheet(_ type: EmojiType, _ title: String ) {
        
        backGroundView.appearBottomSheetView(subView: self.bottomSheet, 292)
        bottomSheet.do {
            $0.configureEmojiType(type)
            $0.configureBottonSheetTitle(title)
        }
    }
}

// MARK: - UITextFieldDelegate

extension NickNameViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        self.checkNickname = text
        
        if !text.isNotContainSpecialCharacters() || text.isEmpty {
            updateTextFieldStatus(false, text.isEmpty)
        } else {
            updateTextFieldStatus(true, true)
        }
    }
    
    private func updateTextFieldStatus(_ isValid: Bool, _ isError: Bool) {
        if isError {
            nicknameTextField.clearErrorMessage()
        } else {
            nicknameTextField.setErrorMessage(I18N.Rule.nickname, true)
        }
        
        self.isValid = isValid
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let currentText = textField.text else { return false }
        let changedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        self.configureNextButtonUI( currentText == changedText)
        
        return changedText.count < 11
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.checkNickname = textField.text ?? ""
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Network

extension NickNameViewController {
    
    private func postNicknameCheck() {
        
        let checkNickname = NicknameRequestDTO(nickname: self.checkNickname)
        AuthAPI.shared.postCheckNickname(to: checkNickname) { result in
            guard let status = result else { return }
            switch status {
            case 200...204:
                self.configureBottomSheet(.smile, I18N.Bottomsheet.nickname)
                self.configureNextButtonUI(true)
            default:
                self.configureBottomSheet(.sad, I18N.Bottomsheet.duplicatedNickname)
                self.configureNextButtonUI(false)
            }
        }
    }
    
}
