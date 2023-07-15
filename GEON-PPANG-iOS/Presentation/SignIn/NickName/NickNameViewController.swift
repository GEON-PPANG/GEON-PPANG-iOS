//
//  NickNameViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class NickNameViewController: BaseViewController {
    
    // MARK: - UI Property
    
    private let naviView = CustomNavigationBar()
    private let titleLabel = UILabel()
    private let nicknameTextField = LoginTextFiledView()
    private lazy var checkButton = CommonButton()
    private lazy var nextButton = CommonButton()
    
    override func setLayout() {
        view.addSubviews(naviView, titleLabel, nicknameTextField, checkButton, nextButton)
        
        naviView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(24)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(74)
        }
        
        checkButton.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(36)
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
        titleLabel.do {
            $0.numberOfLines = 0
            $0.basic(text: "건빵에 오신걸 환영해요!\n어떻게 불러드릴까요?",
                     font: .title1!,
                     color: .gbbGray700!)
        }
        checkButton.do {
            $0.getButtonUI(.clear, .gbbGray300)
            $0.getButtonTitle(.duplicate)
        }
        
        nicknameTextField.do {
            $0.getAccessoryView(nextButton)
            $0.getType(.nickname)
            $0.duplicatedCheck = { data in
                self.checkButton.getButtonUI(.gbbMain2!)
                print(data)
            }
        }
        nextButton.do {
            $0.getButtonUI(.gbbGray200!)
            $0.getButtonTitle(.next)
        }
    }
}
