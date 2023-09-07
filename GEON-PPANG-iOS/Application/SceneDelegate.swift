//
//  SceneDelegate.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/06/21.
//

import UIKit

import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.overrideUserInterfaceStyle = UIUserInterfaceStyle.light
            
//            let rootViewController = TabBarController()
            let rootViewController = ReviewViewController(type: .read, bakeryData: .init(bakeryID: 3, bakeryName: "카페라마스콘", bakeryImageURL: "https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210709_278%2F1625811227308lrWht_JPEG%2FawlHi4WB2wWGQ72DG6Eq2pai.jpg", bakeryIngredients: ["test"], bakeryRegion: ["test"]), reviewID: 18)
            let navigationController = UINavigationController(rootViewController: rootViewController)
            navigationController.isNavigationBarHidden = true
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            self.window = window
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
    
    func changeRootViewControllerToTabBarController() {
        guard let window = window else { return }
        let rootViewController = TabBarController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.isNavigationBarHidden = true
        window.rootViewController = navigationController
        UIView.transition(with: window, duration: 0.2, options: [.transitionCrossDissolve], animations: nil)
    }
    
    func changeRootViewControllerToOnboardingViewController() {
        guard let window = window else { return }
        let rootViewController = OnboardingViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.isNavigationBarHidden = true
        window.rootViewController = navigationController
        UIView.transition(with: window, duration: 0.2, options: [.transitionCrossDissolve], animations: nil)
    }
}
