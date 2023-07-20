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
    private var keyboardHeight: CGFloat = 0
    
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
        
        setNavigationBarHidden()
        dismissKeyboardWhenTappedAround()
        setNotificationCenter()
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        view.addSubviews(naviView,
                         scrollView,
                         bottomView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(titleLabel,
                                passwordTextField,
                                checkPasswordTextField)
        
        bottomView.addSubview(nextButton)
        
        naviView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(118)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(19)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide).priority(.low)
            $0.width.equalTo(scrollView.frameLayoutGuide)
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
            $0.bottom.lessThanOrEqualToSuperview().inset(30)
        }
        
        nextButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.directionalVerticalEdges.equalToSuperview().inset(16)
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
            $0.backgroundColor = .white
            $0.configureRightCount(2, by: 6)
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
            $0.layer.masksToBounds = false
        }
        
        nextButton.do {
            $0.isEnabled = false
            $0.getButtonUI(.gbbGray200!)
            $0.getButtonTitle(.next)
        }
    }
    
    func updateUI(_ isValid: Bool) {
        self.nextButton.do {
            $0.isEnabled = isValid
            $0.getButtonUI(isValid ? .gbbMain2! : .gbbGray200!)
            $0.addAction {
                if isValid {
                    Utils.push(self.navigationController, NickNameViewController())
                }
            }
        }
    }
    
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

    }
    
    func dismissKeyboardWhenTappedAround() {
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                action: #selector(endEditingView))
       tap.cancelsTouchesInView = true
       self.view.addGestureRecognizer(tap)
    }
}

// MARK: - Keyboard Action
extension PasswordViewController {
    
    @objc
    func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
                
        UIView.animate(withDuration: duration) {
            self.bottomView.snp.updateConstraints {
                $0.bottom.equalToSuperview().inset(keyboardHeight)
            }
            self.view.layoutIfNeeded()
        }
        
        scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height), animated: true)
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
                
        UIView.animate(withDuration: duration, animations: {
            self.bottomView.snp.updateConstraints {
                $0.bottom.equalToSuperview().inset(19)
            }
            self.view.layoutIfNeeded()
        })
    }
}
