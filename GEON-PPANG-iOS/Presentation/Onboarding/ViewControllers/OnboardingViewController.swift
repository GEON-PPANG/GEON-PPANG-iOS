//
//  OnboardingViewController.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/11.
//

import UIKit

import SnapKit
import Then

import AuthenticationServices
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

final class OnboardingViewController: BaseViewController {
    
    // MARK: - UI Property
    
    private let logoImage = UIImageView()
    // FIXME: 소셜로그인 버튼 커스텀 디자인 완성되면 바꾸기
    private let kakaoLoginButton = UIButton()
    private let appleLoginButton = ASAuthorizationAppleIDButton()
    private let socialLoginButtonStackView = UIStackView()
    private let emailSignInButton = UIButton()
    private let emailSignUpButton = UIButton()
    private let seperatorView = UIView()
    private let emailButtonStackView = UIStackView()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSocialLoginButtonActions()
    }
    
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
            $0.backgroundColor = .systemYellow
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
    
    private func setSocialLoginButtonActions() {
        
        let kakaoLoginAction = UIAction { [weak self] _ in
            self?.kakaoLoginButtonTapped()
        }
        kakaoLoginButton.addAction(kakaoLoginAction, for: .touchUpInside)
        
        let appleLoginAction = UIAction { [weak self] _ in
            self?.appleLoginButtonTapped()
        }
        appleLoginButton.addAction(appleLoginAction, for: .touchUpInside)
    }
    
}

extension OnboardingViewController {
    
    private func kakaoLoginButtonTapped() {
        
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { token, error in
                guard error == nil
                else {
                    print("login with kakaoTalk failed with error: \(String(describing: error))")
                    return
                }
                print("🪙 token 🪙: \(String(describing: token))")
                
                // TODO: api 나오면 연결
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { token, error in
                guard error == nil
                else {
                    print("login with kakaoTalk failed with error: \(String(describing: error))")
                    return
                }
                print("🪙 token 🪙: \(String(describing: token))")
                
                // TODO: api 나오면 연결
            }
        }
    }
    
    private func appleLoginButtonTapped() {
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
    }
    
}

// MARK: - Delegate

extension OnboardingViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        // TODO: 받아온 credential 처리 로직 고민해보기
        switch authorization.credential {
        case let idCredential as ASAuthorizationAppleIDCredential:
            print("id: \(idCredential)")
        case let pwCredential as ASPasswordCredential:
            print("pw: \(pwCredential)")
        default:
            break
        }
    }
    
}

extension OnboardingViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        return self.view.window!
    }
    
}
