//
//  LauchScreenViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/09/14.
//

import UIKit

import SnapKit

final class LaunchScreenViewController: BaseViewController {
    
    // MARK: - UI Property
    
    private let logoImageView = UIImageView(image: .launchscreenIcon)
    
    // MARK: - Life Cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkUserLoggedIn()
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func checkUserLoggedIn() {
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        if KeychainService.readKeychain(of: .access) != "" {
            refreshAccessToken()
        } else {
            sceneDelegate?.changeRootViewControllerToOnboardingViewController()
        }
    }
    
}

extension LaunchScreenViewController {
    
    private func refreshAccessToken() {
        
        AuthAPI.shared.getTokenRefresh { response in
            guard let response = response,
                  let message = response.message
            else { return }
            
            if response.code == 200 || message == "만료되지 않은 엑세스 토큰입니다" {
                Utils.sceneDelegate?.changeRootViewControllerToTabBarController()
            } else {
                Utils.sceneDelegate?.changeRootViewControllerToOnboardingViewController()
            }
        }
    }
}
