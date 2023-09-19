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
    
    override func setUI() {
        
        view.do {
            $0.backgroundColor = .gbbBackground2
        }
    }
    
    private func checkUserLoggedIn() {
        
        getNickname { nickname in
            guard let nickname = nickname else {
                Utils.sceneDelegate?.changeRootViewControllerToOnboardingViewController()
                return
            }
            
            if nickname.prefix(5) == "GUEST" {
                let viewcontroller = NickNameViewController()
                viewcontroller.naviView.hideBackButton(true)
                Utils.push(self.navigationController, viewcontroller)
            } else {
                Utils.sceneDelegate?.changeRootViewControllerToTabBarController()
            }
        }
    }
    
}

extension LaunchScreenViewController {
    
    private func getNickname(_ completion: @escaping (String?) -> Void) {
        
        MemberAPI.shared.getNickname { result in
            guard let result = result,
                  let response = result.data
            else { return }
            switch result.code {
            case 200:
                completion(response.nickname)
            default:
                completion(nil)
            }
        }
    }
}
