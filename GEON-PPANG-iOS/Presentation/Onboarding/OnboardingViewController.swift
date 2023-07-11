//
//  OnboardingViewController.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/11.
//

import UIKit

import SnapKit
import Then

class OnboardingViewController: BaseViewController {
    
    private let logoImage = UIImageView()
    private lazy var signinButton = UIView()    // 공통 버튼 구현 전까지
    private let signinLabel = UILabel()         // 임시로 레이아웃 잡는 용도
    private lazy var signupButton = UIView()    // 위와
    private let signupLabel = UILabel()         // 동일
    private let latelySigninView = DrawDashLineView()
    private let latelySigninLabel = UILabel()
    private let kakaoButton = UIImageView()
    private let appleButton = UIImageView()
    private let naverButton = UIImageView()
    private let googleButton = UIImageView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func setUI() {
        
        logoImage.do {
            $0.image = .launchscreenIcon
            $0.contentMode = .scaleAspectFit
        }
        
        signinButton.do {
            $0.backgroundColor = .gbbMain2
            $0.makeCornerRound(radius: 12)
        }
        
        signupButton.do {
            $0.makeCornerRound(radius: 12)
            $0.makeBorder(width: 1, color: .gbbGray300!)
        }
        
        signinLabel.do {
            $0.text = "로그인"
            $0.font = .headLine
            $0.textColor = .gbbGray100
            $0.textAlignment = .center
        }
        
        signupLabel.do {
            $0.text = "회원가입"
            $0.font = .bodyB1
            $0.textColor = .gbbGray400
            $0.textAlignment = .center
        }
        
        latelySigninLabel.do {
            $0.text = "최근에 카카오톡으로 로그인 했습니다."
            $0.font = .captionB1
            $0.textColor = .gbbGray500
            $0.textAlignment = .center
            $0.partColorChange(targetString: "카카오톡", textColor: .gbbMain1!) // 특정 문자열의 textColor를 변경
        }
        
        kakaoButton.do {
            $0.image = .kakaoLoginButton
        }
        
        appleButton.do {
            $0.image = .appleLoginButton
        }
        
        naverButton.do {
            $0.image = .naverLoginButton
        }
        
        googleButton.do {
            $0.image = .googleLoginButton
        }
    }
    
    override func setLayout() {
        
        view.addSubviews(logoImage, signinButton, signupButton, latelySigninView, kakaoButton, appleButton, naverButton, googleButton)
        
        signinButton.addSubview(signinLabel)
        signupButton.addSubview(signupLabel)
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
        
        signinLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        signupLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
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
            $0.size.equalTo(convertByWidthRatio(56))
        }
        
        appleButton.snp.makeConstraints {
            $0.top.equalTo(kakaoButton.snp.top)
            $0.leading.equalTo(kakaoButton.snp.trailing).offset(convertByWidthRatio(20))
            $0.size.equalTo(convertByWidthRatio(56))
        }
        
        naverButton.snp.makeConstraints {
            $0.top.equalTo(appleButton.snp.top)
            $0.leading.equalTo(appleButton.snp.trailing).offset(convertByWidthRatio(20))
            $0.size.equalTo(convertByWidthRatio(56))
        }
        
        googleButton.snp.makeConstraints {
            $0.top.equalTo(naverButton.snp.top)
            $0.leading.equalTo(naverButton.snp.trailing).offset(convertByWidthRatio(20))
            $0.size.equalTo(convertByWidthRatio(56))
        }
    }
}
