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
    
    private var password: String = ""
    private var emailValiable: Bool = false {
        didSet {
            configureButtonUI()
        }
    }
    
    private var passwordValiable: Bool = false {
        didSet {
            configureButtonUI()
        }
    }
    
    // MARK: - UI Property
    
    private let naviView = CustomNavigationBar()
    private let scrollView = UIScrollView()
    private let titleLabel = UILabel()
    private let contentView = UIView()
    private let emailTextField = CommonTextView()
    private let passwordTextField = CommonTextView()
    private let checkPasswordTextField = CommonTextView()
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
            $0.cofigureSignInType(.email)
            $0.delegte = self
//            $0.validCheck = { [weak self] valid in
//                self?.emailValiable = valid
//            }
//            $0.tappedCheckButton = {
//                print("tapped")
//            }
        }
        
        passwordTextField.do {
            $0.cofigureSignInType(.password)
            $0.delegte = self
//            $0.duplicatedCheck = { data in
//                self.password = data
//            }
        }
        
        checkPasswordTextField.do {
            $0.cofigureSignInType(.checkPassword)
            $0.delegte = self
//
//            $0.textFieldData = { [weak self] data in
//                if self?.password == data && data.count > 7 {
//                    self?.checkPasswordTextField.clearErrorMessage(true)
//                    self?.passwordValiable = true
//                } else {
//                    self?.checkPasswordTextField.setErrorMessage(I18N.SignIn.checkPassword)
//                    self?.passwordValiable = false
//                }
//            }
        }

        nextButton.do {
            $0.isUserInteractionEnabled = false
            $0.configureButtonUI(.gbbGray200!)
            $0.configureButtonTitle(.next)
        }
    }
    
    func configureButtonUI() {
        
        let isValid = passwordValiable && emailValiable
        
        nextButton.do {
            $0.isUserInteractionEnabled = isValid
            $0.configureButtonUI(isValid ? .gbbMain2!: .gbbGray200!)
        }
    }
    
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

// MARK: - UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {
    
}
