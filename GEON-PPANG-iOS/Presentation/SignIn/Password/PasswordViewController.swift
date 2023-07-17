//
//  PasswordViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class PasswordViewController: BaseViewController {
    
    // MARK: - Property
    
    private var isValid: Bool = false {
        didSet {
            updateUI(isValid)
        }
    }
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    private var password: String = ""
    
    // MARK: - UI Property
    
    private let naviView = CustomNavigationBar()

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let passwordTextField = CommonTextView()
    private let checkPasswordTextField = CommonTextView()
    
    private let bottomView = UIView()
    private let nextButton = CommonButton()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardNotifications()
        setupTapGesture()
    }
    // MARK: - Setting
    
    override func setLayout() {
        view.addSubviews(naviView, scrollView, bottomView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(titleLabel, passwordTextField, checkPasswordTextField)
        bottomView.addSubview(nextButton)
        
        naviView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom)
            $0.bottom.directionalHorizontalEdges.equalTo(safeArea)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.size.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(74)
        }
        
        checkPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(36)
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(74)
        }
        
        bottomView.snp.makeConstraints {
            $0.bottom.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(92)
        }
        
        nextButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
    }
    
    override func setUI() {
        scrollView.do {
            $0.horizontalScrollIndicatorInsets = .zero
            $0.verticalScrollIndicatorInsets = .zero
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
        }
        
        naviView.do {
            $0.configureRightCount(4, by: 6)
            $0.addBackButtonAction(UIAction { _ in
                self.navigationController?.popViewController(animated: true)
            })
        }
        
        titleLabel.do {
            $0.numberOfLines = 0
            $0.basic(text: "회원가입을 위한 \n비밀번호를 입력해주세요!",
                     font: .title1!,
                     color: .gbbGray700!)
        }
        
        passwordTextField.do {
            $0.getType(.password)
            $0.duplicatedCheck = { data in
                self.password = data
            }
        }
        
        checkPasswordTextField.do {
            $0.getAccessoryView(nextButton)
            $0.getType(.checkPassword)
            $0.textFieldData = { [weak self] data in
                if self?.password == data {
                    self?.checkPasswordTextField.clearErrorMessage(true)
                    self?.isValid = true
                } else {
                    self?.checkPasswordTextField.setErrorMessage("비밀번호를 확인해주세요")
                    self?.isValid = false
                }
            }
        }
        
        bottomView.do {
            $0.backgroundColor = .white
            $0.layer.masksToBounds = false
        }
        
        nextButton.do {
            $0.getButtonUI(.gbbGray200!)
            $0.getButtonTitle(.next)
            $0.addAction(UIAction { _ in
                Utils.push(self.navigationController, NickNameViewController())
            }, for: .touchUpInside)
        }
    }
    
    func updateUI(_ isValid: Bool) {
        self.nextButton.do {
            $0.isEnabled = isValid
            $0.getButtonUI(isValid ? .gbbMain2! : .clear, isValid ? .clear : .gbbGray300!)
        }
    }
    
    
       private func registerKeyboardNotifications() {
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
       }
       
       @objc private func keyboardWillShow(_ notification: Notification) {
           guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
           
           let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
           scrollView.contentInset = contentInset
           scrollView.scrollIndicatorInsets = contentInset
       }
       
       @objc private func keyboardWillHide(_ notification: Notification) {
           scrollView.contentInset = .zero
           scrollView.scrollIndicatorInsets = .zero
       }
       
       // MARK: - Tap Gesture Handling
       
       private func setupTapGesture() {
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
           scrollView.addGestureRecognizer(tapGesture)
       }
       
    @objc
    override func dismissKeyboard() {
           view.endEditing(true)
       }
}
