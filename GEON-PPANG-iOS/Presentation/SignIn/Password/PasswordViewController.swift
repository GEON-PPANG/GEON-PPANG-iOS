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
        
        setKeyboardNotificationCenterOnScrollView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dismissKeyboardWhenTappedAround()
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        view.addSubviews(scrollView, naviView, bottomView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(titleLabel, passwordTextField, checkPasswordTextField)
        bottomView.addSubview(nextButton)
        
        naviView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(bottomView.snp.top)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide).priority(.low)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(safeArea).offset(24)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.directionalHorizontalEdges.equalTo(safeArea).inset(24)
            $0.height.equalTo(74)
        }
        
        checkPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(36)
            $0.directionalHorizontalEdges.equalTo(safeArea).inset(24)
            $0.height.equalTo(74)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        bottomView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
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
            $0.backgroundColor = .white
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
            $0.changeLayout = {
                self.bottomView.transform = CGAffineTransform(translationX: 0, y: -50)
            }
        }
        
        checkPasswordTextField.do {
            $0.getType(.checkPassword)
            $0.changeLayout = {
                self.bottomView.transform = CGAffineTransform(translationX: 0, y: -50)
            }
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
    
    private func setKeyboardNotificationCenterOnScrollView() {
        NotificationCenter.default.addObserver(self, selector: #selector(moveUpAboutKeyboardOnScrollView), name: UIResponder.keyboardWillShowNotification, object: nil)

    }
    
    
    @objc
    func moveUpAboutKeyboardOnScrollView(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            self.keyboardHeight = keyboardSize.height
            bottomView.snp.remakeConstraints {
                $0.bottom.equalToSuperview().inset(keyboardHeight)
                $0.horizontalEdges.equalToSuperview()
                $0.height.equalTo(92)
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func dismissKeyboardWhenTappedAround() {
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                action: #selector(updateBottomView))
       tap.cancelsTouchesInView = true
       self.view.addGestureRecognizer(tap)
    }
    
    @objc
    func updateBottomView() {
        view.endEditing(true)
        bottomView.snp.remakeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(92)
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
}
