//
//  EmailViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class EmailViewController: BaseViewController {
    
    // MARK: - UI Property
    
    private let naviView = CustomNavigationBar()
    private let titleLabel = UILabel()
    private let emailTextField = CommonTextView()
    private lazy var checkButton = CommonButton()
    private lazy var nextButton = CommonButton()
    
    // MARK: - Setting
    
    override func setLayout() {
        view.addSubviews(naviView, titleLabel, emailTextField, checkButton, nextButton)
        
        naviView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(24)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(74)
        }
        
        checkButton.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(36)
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(48)
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
    }
    
    override func setUI() {
        naviView.do {
            $0.configureRightCount(3, by: 6)
        }
        titleLabel.do {
            $0.numberOfLines = 0
            $0.basic(text: "회원가입을 위한 \n이메일을 입력해주세요!",
                     font: .title1!,
                     color: .gbbGray700!)
        }
        checkButton.do {
            $0.getButtonUI(.clear, .gbbGray300)
            $0.getButtonTitle(.duplicate)
            $0.addAction(UIAction { _ in
                self.nextButton.do {
                    $0.isUserInteractionEnabled = true
                    $0.getButtonUI(.gbbMain2!)
                }
            }, for: .touchUpInside)
        }
        
        emailTextField.do {
            $0.getAccessoryView(nextButton)
            $0.getType(.email)
            $0.validateEmail()
            $0.validCheck = {
                self.checkButton.do {
                    $0.isEnabled = true
                    $0.getButtonUI(.clear, .gbbMain2!)
                }
            }
            $0.invalidCheck = {
                self.checkButton.do {
                    $0.isEnabled = false
                    $0.getButtonUI(.clear, .gbbGray300)
                }
            }
        }
        
        nextButton.do {
            $0.isUserInteractionEnabled = false
            $0.getButtonUI(.gbbGray200!)
            $0.getButtonTitle(.next)
        }
    }
    
}
