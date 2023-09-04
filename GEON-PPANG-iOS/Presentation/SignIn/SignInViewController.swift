//
//  SignInViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class SignInViewController: BaseViewController {
    
    // MARK: - Property
    
    private var checkEmail: String = ""
    private var password: String = "" {
        didSet {
            configureTextField(isValid: { checkPassword.isEqual(self.password) }, error: I18N.Rule.checkPassword, view: checkPasswordTextField)
        }
    }
    private var checkPassword: String = "" {
        didSet {
            configureTextField(isValid: { checkPassword.isEqual(self.password) }, error: I18N.Rule.checkPassword, view: checkPasswordTextField)

        }
    }
    private var checkEmailIsValid: Bool = false
    private var signInIsValid: [Bool] = [false, false, false]
    private var isValid: Bool = false {
        didSet {
            configureButtonUI(isValid)
        }
    }
    
    // MARK: - UI Property
    
    private let naviView = CustomNavigationBar()
    private let scrollView = UIScrollView()
    private let titleLabel = UILabel()
    private let contentView = UIView()
    private let emailTextField = CommonTextView(.email)
    private let passwordTextField = CommonTextView(.password)
    private let checkPasswordTextField = CommonTextView(.checkPassword)
    private lazy var nextButton = CommonButton()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNotificationCenter(show: #selector(keyboardWillShow), hide: #selector(keyboardWillHide))
        setKeyboardHideGesture()
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        
        view.addSubview(naviView)
        naviView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview()
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom)
            $0.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(24)
        }
        
        contentView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
        }
        
        contentView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(29)
        }
        
        contentView.addSubview(checkPasswordTextField)
        checkPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(29)
            $0.bottom.equalToSuperview()
        }
        
        [emailTextField, passwordTextField, checkPasswordTextField]
            .forEach {
                $0.snp.makeConstraints {
                    $0.directionalHorizontalEdges.equalToSuperview().inset(24)
                    $0.height.equalTo(74)
                }
            }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(CGFloat().heightConsideringBottomSafeArea(54))
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
    }
    
    override func setUI() {
        
        naviView.do {
            $0.configureBottomLine()
            $0.configureRightCount(1, by: 6)
            $0.configureBackButtonAction(UIAction { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
        }
        
        scrollView.do {
            $0.showsVerticalScrollIndicator = false
        }
        
        titleLabel.do {
            $0.numberOfLines = 0
            $0.basic(text: I18N.SignIn.title,
                     font: .title1!,
                     color: .gbbGray700!)
        }
        
        emailTextField.do {
            $0.tappedCheckButton = {
                if self.checkEmailIsValid {
                    self.postCheckEmail()
                }
            }
        }
        
        nextButton.do {
            $0.isUserInteractionEnabled = false
            $0.configureButtonUI(.gbbGray200!)
            $0.configureButtonTitle(.next)
        }
    }
    
    override func setDelegate() {
        
        [emailTextField, passwordTextField, checkPasswordTextField].forEach {
            $0.delegate = self
        }
    }
    
    func configureButtonUI(_ isValid: Bool) {
        
        nextButton.do {
            $0.isUserInteractionEnabled = isValid
            $0.configureButtonUI(isValid ? .gbbMain2!: .gbbGray200!)
        }
    }
    
    func updateButtonStatus() {
        self.isValid = signInIsValid.allSatisfy { $0 == true }
        configureButtonUI(self.isValid)
    }
}

// MARK: - UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        if text.isEmpty {
            textField.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == emailTextField.configureTextField() {
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            if newText == currentText {
                self.signInIsValid[0] = true
            } else {
                self.signInIsValid[0] = false
            }
            updateButtonStatus()
        }
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }

        let signViews: [UITextField: (() -> Bool, String, CommonTextView)] =
        [
            emailTextField.configureTextField(): ({ text.isValidEmail()},
                                                  I18N.Rule.disableEmail,
                                                  emailTextField),
            passwordTextField.configureTextField(): ({ text.isContainNumberAndAlphabet() && text.count >= 8 },
                                                     I18N.Rule.password,
                                                     passwordTextField),
            checkPasswordTextField.configureTextField(): ({ text.isEqual(self.password) },
                                                          I18N.Rule.checkPassword,
                                                          checkPasswordTextField)
        ]
        
        if let (isValid, error, view) = signViews[textField] {
            configureTextField(isValid: isValid, error: error, view: view)
        }
        
        if text.isEmpty {
            [emailTextField, passwordTextField, checkPasswordTextField].forEach {
                $0.clearErrorMessage()
                self.isValid = false
            }
        }
        if emailTextField.configureTextField() == textField {
            self.checkEmail = text
        }

        if passwordTextField.configureTextField() == textField {
            self.password = text
        }

        if checkPasswordTextField.configureTextField() == textField {
            self.checkPassword = text
        }
        
    }
    
    func configureTextField(isValid: () -> Bool,
                            error: String,
                            view: CommonTextView) {
        
        if view == emailTextField {
            self.checkEmailIsValid = isValid()
        }
        if view == passwordTextField {
            self.signInIsValid[1] = isValid()
        }
        if view == checkPasswordTextField {
            self.signInIsValid[2] = isValid()
        }
        if !isValid() {
            view.setErrorMessage(error, true)
        } else {
            view.clearErrorMessage()
        }
        
        updateButtonStatus()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if passwordTextField.configureTextField() == textField {
            self.password = textField.text ?? ""
        }
        
        if checkPasswordTextField.configureTextField() == textField {
            self.checkPassword = textField.text ?? ""
        }
        
        if emailTextField.configureTextField() == textField {
            self.checkEmail = textField.text ?? ""
        }
        textField.resignFirstResponder()
        return true
    }
}

extension SignInViewController {
    
    private func postCheckEmail() {
        let checkEmail = EmailRequestDTO(email: self.checkEmail)
        AuthAPI.shared.postCheckEmail(to: checkEmail) { result in
            guard let status = result else { return }
            switch status {
            case 200...204:
                self.emailTextField.setErrorMessage(I18N.Rule.email, false)
                self.signInIsValid[0] = true
                
            default:
                self.emailTextField.setErrorMessage(I18N.Rule.duplicatedEmail, true)
                self.signInIsValid[0] = false
            }
            self.updateButtonStatus()
        }
    }
}

// MARK: - Keyboard Action

extension SignInViewController {
    
    @objc
    func keyboardWillShow(_ notification: NSNotification) {
        
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        let contentInsets = UIEdgeInsets(top: 0.0,
                                         left: 0.0,
                                         bottom: keyboardHeight + 36,
                                         right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    @objc
    func keyboardWillHide(_ notification: NSNotification) {
        
        let contentInsets = UIEdgeInsets(top: 0.0,
                                         left: 0.0,
                                         bottom: 0.0,
                                         right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}
