//
//  LogInViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/08/28.
//

import UIKit

import SnapKit
import Then

final class LogInViewController: BaseViewController {
    
    // MARK: - Property
    
    private var loginEmail: String = ""
    private var loginPassword: String = ""
    private var IsEmailValid: Bool = false
    private var IsPasswordValid: Bool = false
    private var isValid: Bool = false {
        didSet {
            configureButtonUI(self.isValid)
        }
    }
    
    // MARK: - UI Property
    
    private let naviView = CustomNavigationBar()
    private let titleLabel = UILabel()
    private let emailTextField = CommonTextView(.loginEmail)
    private let passwordTextField = CommonTextView(.loginPassword)
    private let accountLabel = UILabel()
    private let signInButton = UIButton()
    private let loginButton = CommonButton()
    private lazy var backGroundView = BottomSheetAppearView()
    private lazy var bottomSheet = CommonBottomSheet()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setKeyboardHideGesture()
    }
    
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
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
        }
        
        [emailTextField, passwordTextField].forEach {
            $0.snp.makeConstraints {
                $0.directionalHorizontalEdges.equalToSuperview().inset(24)
                $0.height.equalTo(74)
            }
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(CGFloat().heightConsideringBottomSafeArea(54))
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
        
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints {
            $0.bottom.equalTo(loginButton.snp.top).offset(-31)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(accountLabel)
        accountLabel.snp.makeConstraints {
            $0.bottom.equalTo(signInButton.snp.top).offset(-7)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func setUI() {
        
        naviView.do {
            $0.configureBottomLine()
            $0.configureBackButtonAction(UIAction { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
        }
        
        titleLabel.do {
            $0.numberOfLines = 0
            $0.basic(text: I18N.LogIn.title,
                     font: .title1!,
                     color: .gbbGray700!)
        }
        
        loginButton.do {
            $0.isUserInteractionEnabled = false
            $0.configureButtonUI(.gbbGray200!)
            $0.configureButtonTitle(.login)
        }
        
        signInButton.do {
            $0.setTitle(I18N.LogIn.signIn, for: .normal)
            $0.setTitleColor(.gbbGray500!, for: .normal)
            $0.titleLabel?.font = .bodyB2!
            $0.setUnderline()
            $0.addAction(UIAction { [weak self] _ in
                guard let self else { return }
                Utils.push(self.navigationController, SignInViewController())
            }, for: .touchUpInside)
        }
        
        accountLabel.do {
            $0.basic(text: I18N.LogIn.noAccount,
                     font: .subHead!,
                     color: .gray_500!)
        }
        
        bottomSheet.do {
            $0.configureEmojiType(.sad)
            $0.configureBottonSheetTitle(I18N.Bottomsheet.checkIdPassword)
        }
    }
    
    override func setDelegate() {
        
        [emailTextField, passwordTextField].forEach {
            $0.delegate = self
        }
    }
    
    func configureButtonUI(_ isValid: Bool) {
        
        loginButton.do {
            $0.isUserInteractionEnabled = isValid
            $0.configureButtonUI(isValid ? .gbbMain2!: .gbbGray200!)
            $0.tappedCommonButton = {
                if isValid {
                    self.postLogin()
                }
            }
        }
    }
    
    func configureBottomSheet() {
        
        backGroundView.appearBottomSheetView(subView: self.bottomSheet, 316)
        bottomSheet.do {
            $0.dismissBottomSheet = {
                self.backGroundView.dissmissFromSuperview()
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        switch textField {
        case emailTextField.configureTextField():
            self.loginEmail = text
            self.IsEmailValid = (text.isValidEmail() && !emailTextField.fetchText().isEmpty) ? true : false
        case passwordTextField.configureTextField():
            self.loginPassword = text
            self.IsPasswordValid = !passwordTextField.fetchText().isEmpty ? true : false
        default:
            break
        }
        
        self.isValid = IsEmailValid && IsPasswordValid
        configureButtonUI(self.isValid)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Network

extension LogInViewController {
    
    private func postLogin() {
        
        let loginData = LoginRequestDTO(email: self.loginEmail, password: self.loginPassword)
        AuthAPI.shared.postLogin(to: loginData) { result in
            guard let status = result else { return }
            switch status {
            case 200...204:
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                sceneDelegate?.changeRootViewControllerToTabBarController()
            default:
                self.configureBottomSheet()
                self.configureButtonUI(false)
            }
        }
    }
}
