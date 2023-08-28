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
    
    private var emailValid: Bool = false {
        didSet {
            configureButtonUI()
        }
    }
    
    private var passwordValid: Bool = false {
        didSet {
            configureButtonUI()
        }
    }
    
    // MARK: - UI Property
    
    private let naviView = CustomNavigationBar()
    private let titleLabel = UILabel()
    private let emailTextField = CommonTextView()
    private let passwordTextField = CommonTextView()
    private let accountLabel = UILabel()
    private let signInButton = UIButton()
    private let loginButton = CommonButton()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissKeyboardWhenTappedAround()
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
            $0.configureRightCount(1, by: 6)
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
        
        emailTextField.do {
            $0.cofigureSignInType(.loginEmail)
            $0.validCheck = { [weak self] valid in
                self?.emailValid = valid
            }
        }
        
        passwordTextField.do {
            $0.cofigureSignInType(.loginPassword)
            $0.validCheck = { [weak self] valid in
                self?.passwordValid = valid
            }
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
        }
        
        accountLabel.do {
            $0.basic(text: I18N.LogIn.noAccount,
                     font: .subHead!,
                     color: .gray_500!)
        }
        
    }
    
    func configureButtonUI() {
        
        let valid = emailValid && passwordValid
        loginButton.do {
            $0.isUserInteractionEnabled = valid
            $0.configureButtonUI(valid ? .gbbMain2!: .gbbGray200!)
        }
    }
    
    func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(endEditingView))
        tap.cancelsTouchesInView = true
        self.view.addGestureRecognizer(tap)
    }
}
