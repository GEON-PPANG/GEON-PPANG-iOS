//
//  LoginRequiredViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/30/24.
//

import UIKit

import AuthenticationServices
import SnapKit
import Then

final class LoginRequiredViewController: BaseViewController {
    
    // MARK: - Property
    
    enum ViewType {
        case recommendation
        case profile
        case bookmark
        case writeReview
        case reportReview
    }
    
    let viewType: ViewType
    private var descriptionLabelText: String {
        switch viewType {
        case .recommendation: I18N.LoginRequiredViewController.recommendation
        case .profile: I18N.LoginRequiredViewController.profile
        case .bookmark: I18N.LoginRequiredViewController.bookmark
        case .writeReview: I18N.LoginRequiredViewController.writeReview
        case .reportReview: I18N.LoginRequiredViewController.reportReview
        }
    }
    
    // MARK: - UI Property
    
    private let loginImageView = UIImageView(image: .loginIcon)
    private let loginLabel = UILabel()
    private let kakaoLoginButton = UIButton()
    private let appleLoginButton = UIButton()
    private let socialLoginButtonStackView = UIStackView()
    private let emailLogInButton = UIButton()
    private let emailSignInButton = UIButton()
    private let seperatorView = UIView()
    private let emailButtonStackView = UIStackView()
    
    // MARK: - Life Cycle
    
    init(viewType: ViewType) {
        self.viewType = viewType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSocialLoginButtonActions()
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        
        view.addSubview(loginImageView)
        loginImageView.snp.makeConstraints {
            $0.size.equalTo(64)
            $0.top.equalToSuperview().offset(28)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(loginLabel)
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(loginImageView.snp.bottom).offset(18)
            $0.directionalHorizontalEdges.equalToSuperview()
        }
        
        view.addSubview(socialLoginButtonStackView)
        socialLoginButtonStackView.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        view.addSubview(emailButtonStackView)
        emailButtonStackView.snp.makeConstraints {
            $0.top.equalTo(socialLoginButtonStackView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
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
    }
    
    override func setUI() {
        loginLabel.do {
            $0.text = self.descriptionLabelText
            $0.font = .title2
            $0.numberOfLines = 2
            $0.textAlignment = .center
            $0.partColorChange(targetString: "로그인", textColor: .gbbMain2)
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
            $0.setTitleColor(.gbbGray500, for: .normal)
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
                guard let token = token, let self
                else { return }
                
                KeychainService.setKeychain(of: .socialAuth, with: token)
                KeychainService.setKeychain(of: .socialType, with: "KAKAO")
                
                let request = SignUpRequestDTO(
                    platformType: .kakao,
                    email: "",
                    password: "",
                    nickname: ""
                )
                
                guard let presenting = self.presentingViewController as? UINavigationController else { return }
                self.postSignUp(with: request, viewController: self) { role in
                    KeychainService.setKeychain(of: .role, with: role)
                    self.dismiss(animated: true) {
                        if role == "ROLE_MEMBER" {
                            DispatchQueue.main.async {
                                Utils.sceneDelegate?.changeRootViewControllerToTabBarController()
                            }
                        } else {
                            DispatchQueue.main.async {
                                Utils.push(presenting, NickNameViewController())
                            }
                        }
                    }
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

extension LoginRequiredViewController {
    
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
        guard let presenting = self.presentingViewController as? UINavigationController else { return }
        dismiss(animated: true) {
            Utils.push(presenting, LogInViewController())
        }
    }
    
    private func emailSignInButtonTapped() {
        guard let presenting = self.presentingViewController as? UINavigationController else { return }
        dismiss(animated: true) {
            Utils.push(presenting, SignInViewController())
        }
    }
    
}

extension LoginRequiredViewController: LoginProtocol {}

extension LoginRequiredViewController: ASAuthorizationControllerDelegate {
    
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
                
                guard let presenting = self.presentingViewController as? UINavigationController else { return }
                self.postSignUp(with: request, viewController: self) { role in
                    KeychainService.setKeychain(of: .role, with: role)
                    self.dismiss(animated: true) {
                        if role == "ROLE_MEMBER" {
                            DispatchQueue.main.async {
                                Utils.sceneDelegate?.changeRootViewControllerToTabBarController()
                            }
                        } else {
                            DispatchQueue.main.async {
                                Utils.push(presenting, NickNameViewController())
                            }
                        }
                    }
                }
                
            case .revoked:
                print("❌ User revoked ❌")
                
            default:
                print("❌ Unknown error: \(state) ❌")
            }
        }
    }
    
}

extension LoginRequiredViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        return self.view.window!
    }
    
}
