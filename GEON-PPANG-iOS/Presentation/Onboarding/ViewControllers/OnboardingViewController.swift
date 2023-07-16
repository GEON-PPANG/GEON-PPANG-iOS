//
//  OnboardingViewController.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class OnboardingViewController: BaseViewController {
    
    // MARK: - UI Property
    
    private let logoImage = UIImageView()
    private lazy var signinButton = CommonButton()
    private lazy var signupButton = CommonButton()
    private let latelySigninView = DrawDashLineView()
    private let latelySigninLabel = UILabel()
    private lazy var kakaoButton = UIButton()
    private lazy var appleButton = UIButton()
    private lazy var naverButton = UIButton()
    private lazy var googleButton = UIButton()
    
    // MARK: - Setting
    
    override func setUI() {
        
        logoImage.do {
            $0.image = .launchscreenIcon
            $0.contentMode = .scaleAspectFit
        }
        
        signinButton.do {
            $0.getButtonTitle(.login)
            $0.getButtonUI(.gbbMain2!)
        }
        
        signupButton.do {
            $0.getButtonTitle(.signIn)
            $0.getButtonUI(.gbbWhite!, .gbbGray300)
        }
        
        latelySigninLabel.do {
            $0.text = I18N.Onboarding.latelySigninText
            $0.font = .captionB1
            $0.textColor = .gbbGray500
            $0.textAlignment = .center
            $0.partColorChange(targetString: I18N.Onboarding.latelySigninSNS, textColor: .gbbMain1!) // 특정 문자열의 textColor를 변경
        }
        
        kakaoButton.do {
            $0.setImage(.kakaoLoginButton, for: .normal)
        }
        
        appleButton.do {
            $0.setImage(.appleLoginButton, for: .normal)
        }
        
        naverButton.do {
            $0.setImage(.naverLoginButton, for: .normal)
        }
        
        googleButton.do {
            $0.setImage(.googleLoginButton, for: .normal)
        }
    }
    
    override func setLayout() {
        
        view.addSubviews(logoImage, signinButton, signupButton, latelySigninView, kakaoButton, appleButton, naverButton, googleButton)
        
        latelySigninView.addSubview(latelySigninLabel)
        
        logoImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(convertByHeightRatio(190))
            $0.centerX.equalToSuperview()
            $0.height.equalTo(convertByHeightRatio(179))
        }
        
        signinButton.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(convertByHeightRatio(71))
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(convertByHeightRatio(56))
        }
        
        signupButton.snp.makeConstraints {
            $0.top.equalTo(signinButton.snp.bottom).offset(convertByHeightRatio(20))
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(convertByHeightRatio(56))
        }
        
        latelySigninView.snp.makeConstraints {
            $0.top.equalTo(signupButton.snp.bottom).offset(convertByHeightRatio(65))
            $0.directionalHorizontalEdges.equalToSuperview().inset(77)
            $0.height.equalTo(convertByHeightRatio(30))
        }
        
        latelySigninLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        kakaoButton.snp.makeConstraints {
            $0.top.equalTo(latelySigninView.snp.bottom).offset(convertByHeightRatio(23))
            $0.leading.equalToSuperview().inset(convertByWidthRatio(45))
        }
        
        appleButton.snp.makeConstraints {
            $0.top.equalTo(kakaoButton)
            $0.leading.equalTo(kakaoButton.snp.trailing).offset(convertByWidthRatio(20))
        }
        
        naverButton.snp.makeConstraints {
            $0.top.equalTo(appleButton)
            $0.leading.equalTo(appleButton.snp.trailing).offset(convertByWidthRatio(20))
        }
        
        googleButton.snp.makeConstraints {
            $0.top.equalTo(naverButton)
            $0.leading.equalTo(naverButton.snp.trailing).offset(convertByWidthRatio(20))
        }
    }
}
