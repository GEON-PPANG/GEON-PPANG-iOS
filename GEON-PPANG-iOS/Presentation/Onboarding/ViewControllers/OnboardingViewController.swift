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
    private let kakaoLoginButton = UIButton()
    private let appleLoginButton = UIButton()
    private let socialLoginButtonStackView = UIStackView()
    private let emailLogInButton = UIButton()
    private let emailSignInButton = UIButton()
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
        
        emailLogInButton.snp.makeConstraints {
            $0.height.equalTo(17)
        }
        
        emailSignInButton.snp.makeConstraints {
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
        
        emailLogInButton.do {
            $0.setTitle(I18N.Onboarding.emailSignIn, for: .normal)
            $0.setTitleColor(.gbbGray400, for: .normal)
            $0.titleLabel?.font = .captionB1
            $0.addAction(UIAction { [weak self] _ in
                self?.emailLogInButtonTapped()
            }, for: .touchUpInside)
        }
        
        emailSignInButton.do {
            $0.setTitle(I18N.Onboarding.emailSignUp, for: .normal)
            $0.setTitleColor(.gbbGray400, for: .normal)
            $0.titleLabel?.font = .captionB1
            $0.addAction(UIAction { [weak self] _ in
                self?.emailSignInButtonTapped()
            }, for: .touchUpInside)
        }
        
        seperatorView.do {
            $0.backgroundColor = .gbbGray400
        }
        
        emailButtonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 12
            $0.addArrangedSubviews(emailLogInButton, seperatorView, emailSignInButton)
        }
    }
    
    private func setSocialLoginButtonActions() {
        
        let kakaoLoginAction = UIAction { [weak self] _ in
            self?.getKakaoAuthCode { token in
                guard let token = token
                else { return }
                
                KeychainService.setKeychain(of: .socialAuth, with: token)
                
                let request = SignUpRequestDTO(
                    platformType: .kakao,
                    email: "",
                    password: "",
                    nickname: ""
                )
                self?.postSignUp(with: request)
            }
        }
        kakaoLoginButton.addAction(kakaoLoginAction, for: .touchUpInside)
        
        let appleLoginAction = UIAction { [weak self] _ in
            self?.appleLoginButtonTapped()
        }
        appleLoginButton.addAction(appleLoginAction, for: .touchUpInside)
    }
    
    // TODO: 로그인 / 회원가입 API 추가
    // TODO: 완료 시 rootVC 변경
    // TODO: 이메일로 로그인 / 회원가입 완료 시 연결하기
}

extension OnboardingViewController {
    
    private func getKakaoAuthCode(_ completion: @escaping (String?) -> Void) {
        
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { response, error in
                
                guard error == nil
                else {
                    print("login with kakaoTalk failed with error: \(String(describing: error))")
                    return
                }
                
                guard let token = response?.accessToken
                else { return }
                
                completion(token)
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { response, error in
                guard error == nil
                else {
                    print("login with kakaoTalk failed with error: \(String(describing: error))")
                    return
                }
                
                guard let token = response?.accessToken
                else { return }
                
                completion(token)
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
    
    private func emailLogInButtonTapped() {
        Utils.push(self.navigationController, LogInViewController())
    }
    
    private func emailSignInButtonTapped() {
        Utils.push(self.navigationController, SignInViewController())
    }
    
}

extension OnboardingViewController {
    
    private func postSignUp(with request: SignUpRequestDTO) {
        AuthAPI.shared.postSignUp(with: request) { status in
            guard let code = status?.code else { return }
            switch code {
            case 200...299:
                Utils.push(self.navigationController, NickNameViewController())
                dump(status)
            default:
                dump(status)
                Utils.showAlert(title: "에러", description: "실패", at: self)
            }
        }
    }
    
}

// MARK: - Delegate

extension OnboardingViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let authCode = credential.authorizationCode,
              let authCodeString = String(data: authCode, encoding: .utf8)
        else { return }
        KeychainService.setKeychain(of: .socialAuth, with: authCodeString)
        
        let userIdentifier = credential.user
        let appleProvider = ASAuthorizationAppleIDProvider()
        appleProvider.getCredentialState(forUserID: userIdentifier) { state, err in
            
            guard err == nil
            else {
                print("❌ \(String(describing: err)) ❌")
                return
            }
            
            switch state {
            case .authorized:
                print("🔴 User authorized 🔴")
                
                let request = SignUpRequestDTO(
                    platformType: .apple,
                    email: KeychainService.readKeychain(of: .userEmail),
                    password: "",
                    nickname: ""
                )
                self.postSignUp(with: request)
                
            case .notFound:
                print("🔴 User not found 🔴")
                guard let email = credential.email else {
                    print("❌ User email not found ❌")
                    return
                }
                KeychainService.setKeychain(of: .userEmail, with: email)
                
                let request = SignUpRequestDTO(
                    platformType: .apple,
                    email: KeychainService.readKeychain(of: .userEmail),
                    password: "",
                    nickname: ""
                )
                self.postSignUp(with: request)
                
            case .revoked:
                print("❌ User revoked ❌")
                
            default:
                print("❌ Unknown error: \(state) ❌")
            }
        }
    }
    
}

extension OnboardingViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        return self.view.window!
    }
    
}
