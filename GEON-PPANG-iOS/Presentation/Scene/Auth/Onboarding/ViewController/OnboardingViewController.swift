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

final class OnboardingViewController: BaseViewController {
    
    // MARK: - UI Property
    
    private let skipLoginButton = UIButton()
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
        view.addSubview(skipLoginButton)
        skipLoginButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(28)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(25)
        }
        
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
        skipLoginButton.do {
            $0.setTitle("둘러보기", for: .normal)
            $0.setTitleColor(.gbbGray300, for: .normal)
            $0.titleLabel?.font = .captionB1
            $0.addAction(UIAction { [weak self] _ in
                self?.skipLoginButtonTapped()
            }, for: .touchUpInside)
        }
        
        logoImage.do {
            $0.image = .Icon.launchscreen
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
            
            KakaoService.getKakaoAuthCode { token in
                guard let token = token
                else { return }
                
                KeychainService.setKeychain(of: .socialAuth, with: token)
                KeychainService.setKeychain(of: .socialType, with: "KAKAO")
                
                let request = SignUpRequestDTO(
                    platformType: .kakao,
                    email: "",
                    password: "",
                    nickname: ""
                )
                
                self?.postSignUp(with: request) { role in
                    KeychainService.setKeychain(of: .role, with: role)
                    self?.check(role: role)
                }
            }
        }
        kakaoLoginButton.addAction(kakaoLoginAction, for: .touchUpInside)
        
        let appleLoginAction = UIAction { [weak self] _ in
            self?.appleLoginButtonTapped()
        }
        appleLoginButton.addAction(appleLoginAction, for: .touchUpInside)
    }
}

extension OnboardingViewController {
    
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
    
    private func skipLoginButtonTapped() {
        KeychainService.setKeychain(of: .role, with: "VISITOR")
        KeychainService.deleteKeychain(of: .access)
        KeychainService.deleteKeychain(of: .refresh)
        Utils.sceneDelegate?.changeRootViewControllerToTabBarController()
    }
    
    private func check(role: String) {
        switch role {
        case UserRole.guest.rawValue:
            let viewController = NickNameViewController()
            viewController.naviView.hideBackButton(true)
            
            let socialType = KeychainService.readKeychain(of: .socialType)
            AnalyticManager.log(event: .onboarding(.startSignup(signUpType: socialType)))
            
            Utils.push(self.navigationController, viewController)
            
        case UserRole.member.rawValue, UserRole.visitor.rawValue:
            Utils.sceneDelegate?.changeRootViewControllerToTabBarController()
            
        default:
            print("❌❌❌ Unknown Role ❌❌❌")
            let viewController = OnboardingViewController()
            Utils.push(self.navigationController, viewController)
        }
    }
    
}

extension OnboardingViewController {
    
    private func postSignUp(with request: SignUpRequestDTO, completion: ((String) -> Void)?) {
        
        AuthAPI.shared.postSignUp(request: request) { response in
            
            guard let code = response?.code else { return }
            switch code {
            case 200...299:
                guard let userID = response?.data?.memberID,
                      let role = response?.data?.role
                else { return }
                AnalyticManager.set(userId: userID)
                completion?(role)
            default:
                Utils.showAlert(title: "에러", description: "실패", at: self)
            }
        }
    }
    
    private func getNickname(_ completion: @escaping (String?, Int?) -> Void) {
        
        MemberAPI.shared.getNickname { result, err  in
            
            if err == 403 { completion(nil, err); return }
            
            guard let result = result,
                  let response = result.data
            else {  completion(nil, nil); return }

            switch result.code {
            case 200:
                completion(response.nickname, nil)
            default:
                completion(nil, nil)
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
        KeychainService.setKeychain(of: .socialType, with: "APPLE")
        
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
                
                if let email = credential.email, email != "" {
                    KeychainService.setKeychain(of: .userEmail, with: email)
                }
                
                let request = SignUpRequestDTO(
                    platformType: .apple,
                    email: KeychainService.readKeychain(of: .userEmail),
                    password: "",
                    nickname: ""
                )
                
                self.postSignUp(with: request) { role in
                    KeychainService.setKeychain(of: .role, with: role)
                    self.check(role: role)
                }
                
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
