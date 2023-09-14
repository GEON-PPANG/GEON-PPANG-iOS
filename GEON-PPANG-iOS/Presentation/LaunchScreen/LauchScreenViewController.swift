//
//  LauchScreenViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/09/14.
//

import UIKit

import SnapKit

final class LauchScreenViewController: BaseViewController {
    
    // MARK: - UI Property
    
    private let logoImageView = UIImageView(image: .launchscreenIcon)
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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

extension LauchScreenViewController {
    
    private func refreshAccessToken() {
        
        AuthAPI.shared.getTokenRefresh { response in
            guard let response = response else { return }
            switch response.code {
            case 200:
                Utils.sceneDelegate?.changeRootViewControllerToTabBarController()
            default:
                Utils.sceneDelegate?.changeRootViewControllerToOnboardingViewController()
            }
        }
    }
}
