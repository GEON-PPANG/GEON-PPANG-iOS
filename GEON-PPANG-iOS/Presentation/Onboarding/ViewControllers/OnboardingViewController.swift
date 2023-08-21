//
//  OnboardingViewController.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/11.
//

import UIKit
import AuthenticationServices

import SnapKit
import Then

final class OnboardingViewController: BaseViewController {
    
    // MARK: - UI Property
    
    private let logoImage = UIImageView()
    private let kakaoLoginButton = UIButton()
    private let appleLoginButton = UIButton()
    private let socialLoginButtonStackView = UIStackView()
    private let emailSignInButton = UIButton()
    private let emailSignUpButton = UIButton()
    private let seperatorView = UIView()
    private let emailButtonStackView = UIStackView()
    
    // MARK: - Setting
    
    override func setLayout() {
        
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(convertByHeightRatio(190))
            $0.centerX.equalToSuperview()
            $0.height.equalTo(convertByHeightRatio(179))
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        view.addSubview(socialLoginButtonStackView)
        socialLoginButtonStackView.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(56)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        emailSignInButton.snp.makeConstraints {
            $0.height.equalTo(17)
        }
        
        emailSignUpButton.snp.makeConstraints {
            $0.height.equalTo(17)
        }
        
        seperatorView.snp.makeConstraints {
            $0.height.equalTo(12)
            $0.width.equalTo(1)
        }
        
        view.addSubview(emailButtonStackView)
        emailButtonStackView.snp.makeConstraints {
            $0.top.equalTo(socialLoginButtonStackView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func setUI() {
        
        logoImage.do {
            $0.image = .launchscreenIcon
            $0.contentMode = .scaleAspectFit
        }
        
        kakaoLoginButton.do {
            $0.setImage(.kakaoLoginButton, for: .normal)
        }
        
        appleLoginButton.do {
            $0.setImage(.appleLoginButton, for: .normal)
        }
        
        socialLoginButtonStackView.do {
            $0.axis = .vertical
            $0.spacing = 10
            $0.addArrangedSubviews(kakaoLoginButton, appleLoginButton)
        }
        
        emailSignInButton.do {
            $0.setTitle("이메일로 로그인", for: .normal)
            $0.setTitleColor(.gbbGray400, for: .normal)
            $0.titleLabel?.font = .captionB1
        }
        
        emailSignUpButton.do {
            $0.setTitle("이메일로 회원가입", for: .normal)
            $0.setTitleColor(.gbbGray400, for: .normal)
            $0.titleLabel?.font = .captionB1
        }
        
        seperatorView.do {
            $0.backgroundColor = .gbbGray400
        }
        
        emailButtonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 12
            $0.addArrangedSubviews(emailSignInButton, seperatorView, emailSignUpButton)
        }
    }
    
    // TODO: 로그인 / 회원가입 API 추가
    // TODO: 완료 시 rootVC 변경
    // TODO: 이메일로 로그인 / 회원가입 완료 시 연결하기
}
