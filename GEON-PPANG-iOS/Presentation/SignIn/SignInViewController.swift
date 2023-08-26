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
    
    private var isValid: Bool = false {
        didSet {
            configureButtonUI(isValid)
        }
    }
    
    // MARK: - UI Property
    
    private let naviView = CustomNavigationBar()
    private let titleLabel = UILabel()
    private let emailTextField = CommonTextView()
    private let passwordTextField = CommonTextView()
    private let checkPasswordTextField = CommonTextView()
    private lazy var nextButton = CommonButton()
    private lazy var backGroundView = BottomSheetAppearView()
    private lazy var bottomSheet = CommonBottomSheet()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissKeyboardWhenTappedAround()
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
            $0.top.equalTo(naviView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(24)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(29)
        }
        
        view.addSubview(checkPasswordTextField)
        checkPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(29)
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
        
        view.addSubview(backGroundView)
    }
    
    override func setUI() {
        
        naviView.do {
            $0.configureBottomLine()
            $0.configureRightCount(1, by: 6)
            $0.configureBackButtonAction(UIAction { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
        }
        
        titleLabel.do {
            $0.numberOfLines = 0
            $0.basic(text: "회원가입을 위한 \n정보를 입력해주세요!",
                     font: .title1!,
                     color: .gbbGray700!)
        }
        
        emailTextField.do {
            $0.cofigureSignInType(.email)
            $0.validCheck = { [weak self] valid in
                self?.isValid = valid
            }
        }
        
        passwordTextField.do {
            $0.cofigureSignInType(.password)
            $0.duplicatedCheck = { data in
                self.password = data
            }
        }
        
        checkPasswordTextField.do {
            $0.cofigureSignInType(.checkPassword)
            
            $0.textFieldData = { [weak self] data in
                if self?.password == data && data.count > 7 {
                    self?.checkPasswordTextField.clearErrorMessage(true)
                    self?.isValid = true
                } else {
                    self?.checkPasswordTextField.setErrorMessage("비밀번호를 확인해주세요")
                    self?.isValid = false
                }
            }
        }
                
        nextButton.do {
            $0.isUserInteractionEnabled = false
            $0.configureButtonUI(.gbbGray200!)
            $0.configureButtonTitle(.next)
        }
        
        bottomSheet.do {
            $0.getEmojiType(.smile)
            $0.getBottonSheetTitle(I18N.Bottomsheet.email)
            $0.dismissBottomSheet = {
                self.backGroundView.dissmissFromSuperview()
                self.nextButton.do {
                    $0.isUserInteractionEnabled = true
                    $0.configureButtonUI(.gbbMain2!)
                    $0.tappedCommonButton = {
                        Utils.push(self.navigationController, PasswordViewController())
                    }
                }
            }
        }
    }
    
    func configureButtonUI(_ isValid: Bool) {
        
        if !isValid {
            nextButton.do {
                $0.isUserInteractionEnabled = false
                $0.configureButtonUI(.gbbGray200!)
            }
        }
    }
    
    func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(endEditingView))
        tap.cancelsTouchesInView = true
        self.view.addGestureRecognizer(tap)
    }

}
