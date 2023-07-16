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
    
    // MARK: - UI Property
    
    private let naviView = CustomNavigationBar()
    private let titleLabel = UILabel()
    private let passwordTextField = CommonTextView()
    private let checkPasswordTextFiedl = CommonTextView()
    private lazy var nextButton = CommonButton()
    
    // MARK: - Setting
    
    override func setLayout() {
        view.addSubviews(naviView, titleLabel, passwordTextField, checkPasswordTextFiedl, nextButton)
        
        naviView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(24)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(74)
        }
        
        checkPasswordTextFiedl.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(36)
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(74)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(48)
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
    }
    
    override func setUI() {
        naviView.do {
            $0.configureRightCount(4, by: 6)
        }
        titleLabel.do {
            $0.numberOfLines = 0
            $0.basic(text: "회원가입을 위한 \n비밀번호를 입력해주세요!",
                     font: .title1!,
                     color: .gbbGray700!)
        }

        passwordTextField.do {
           
            $0.getAccessoryView(nextButton)
            $0.getType(.password)
            $0.duplicatedCheck = { data in
                print(data)
            }
        }
        
        checkPasswordTextFiedl.do {
            $0.getAccessoryView(nextButton)
            $0.getType(.checkPassword)
            $0.duplicatedCheck = { data in
                print(data)
            }
        }
        
        nextButton.do {
            $0.getButtonUI(.gbbGray200!)
            $0.getButtonTitle(.next)
            $0.addAction(UIAction { _ in
                Utils.push(self.navigationController, PasswordViewController())
            }, for: .touchUpInside)
        }
    }
}
