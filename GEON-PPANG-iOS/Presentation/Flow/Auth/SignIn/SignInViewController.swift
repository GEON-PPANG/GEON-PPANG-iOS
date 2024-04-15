//
//  SignInViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/15.
//

import UIKit

import SnapKit
import Then

import Amplitude

struct SignViewData {
    var isValid: () -> Bool
    var description: String
    var textView: CommonTextView
}

final class SignInViewController: BaseViewController {
    
    // MARK: - Property
    
    private var checkEmail: String = ""
    private var checkPassword: String = ""
    private var password: String = "" {
        didSet {
            configureCommonView(isValid: { checkPassword.isEqual(self.password) ||  checkPassword.isEmpty},
                                error: I18N.Rule.checkPassword,
                                view: checkPasswordTextField)
        }
    }
    
    private var isValidCheckEmail: Bool = false
    private var isValidButton: [Bool] = [false, false, false] {
        didSet {
            updateButtonStatus()
        }
    }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AnalyticManager.log(event: .onboarding(.startSignup(signUpType: AnalyticEventType.EMAIL.rawValue)))
    }
    
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
                if self.isValidCheckEmail {
                    self.postCheckEmail()
                }
            }
            $0.addAction(UIAction { [weak self] _ in
                guard let self else { return }
                self.isValidButton[0] = false
            }, for: .editingChanged)
        }
        
        nextButton.do {
            $0.configureButtonTitle(.next)
            $0.configureButtonUI(.gbbGray200!)
            $0.isUserInteractionEnabled = false
        }
    }
    
    override func setDelegate() {
        
        [emailTextField, passwordTextField, checkPasswordTextField].forEach {
            $0.delegate = self
        }
    }
    
    func configureButtonUI(_ isValid: Bool) {
        
        nextButton.do {
            $0.configureButtonUI(isValid ? .gbbMain2!: .gbbGray200!)
            $0.isUserInteractionEnabled = isValid
            $0.tappedCommonButton = { [weak self] in
                guard let self else { return }
                let nicknameViewController = NickNameViewController()
                nicknameViewController.email = self.checkEmail
                nicknameViewController.password = self.checkPassword
                nicknameViewController.isSocial = false
                Utils.push(self.navigationController, nicknameViewController)
            }
        }
    }
    
    func updateButtonStatus() {
        
        self.isValid = isValidButton.allSatisfy { $0 == true }
        configureButtonUI(self.isValid)
    }
}

// MARK: - UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        let signViews: [UITextField: SignViewData] = [
            emailTextField.configureTextField(): SignViewData(isValid: { text.isValidEmail() },
                                                              description: I18N.Rule.disableEmail,
                                                              textView: emailTextField),
            passwordTextField.configureTextField(): SignViewData(isValid: { text.isContainNumberAndAlphabet() && text.count >= 8 },
                                                                 description: I18N.Rule.password,
                                                                 textView: passwordTextField),
            checkPasswordTextField.configureTextField(): SignViewData(isValid: { text.isEqual(self.password) },
                                                                      description: I18N.Rule.checkPassword,
                                                                      textView: checkPasswordTextField)
        
        ]

        if let signViewData = signViews[textField] {
            let isValid = signViewData.isValid
            let error = signViewData.description
            let view = signViewData.textView
            configureCommonView(isValid: isValid, error: error, view: view)
        }
        
        if text.isEmpty {
            [emailTextField, passwordTextField, checkPasswordTextField].forEach {
                $0.clearErrorMessage()
                self.isValid = false
            }
        }
        
        configureTextFieldText(textField)
    }
    
    func configureCommonView(isValid: () -> Bool,
                             error: String,
                             view: CommonTextView) {
        
        switch view {
        case emailTextField:
            self.isValidCheckEmail = isValid()
        case passwordTextField:
            self.isValidButton[1] = isValid()
        case checkPasswordTextField:
            self.isValidButton[2] = self.checkPassword.isEmpty ? false : isValid()
        default:
            break
        }
        
        if !isValid() {
            view.setErrorMessage(error, true)
        } else {
            view.clearErrorMessage()
        }
        
        updateButtonStatus()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        configureTextFieldText(textField)
        textField.resignFirstResponder()
        return true
    }
    
    func configureTextFieldText(_ textField: UITextField) {
        
        let text = textField.text ?? ""
        
        switch textField {
        case passwordTextField.configureTextField():
            self.password = text
        case checkPasswordTextField.configureTextField():
            self.checkPassword = text
        case emailTextField.configureTextField():
            self.checkEmail = text
        default:
            break
        }
    }
}

extension SignInViewController {
    
    private func postCheckEmail() {
        
        let checkEmail = EmailRequestDTO(email: self.checkEmail)
        ValidationAPI.shared.postCheckEmail(request: checkEmail) { result in
            guard let status = result else { return }
            switch status {
            case 200...204:
                DispatchQueue.main.async {
                    self.emailTextField.setErrorMessage(I18N.Rule.email, false)
                    self.isValidButton[0] = true
                }
                
            default:
                DispatchQueue.main.async {
                    self.emailTextField.setErrorMessage(I18N.Rule.duplicatedEmail, true)
                    self.isValidButton[0] = false
                }
            }
            DispatchQueue.main.async {
                self.updateButtonStatus()
            }
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
