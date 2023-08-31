//
//  SceneDelegate.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/06/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.overrideUserInterfaceStyle = UIUserInterfaceStyle.light
            
            let rootViewController = TabBarController()
            let navigationController = UINavigationController(rootViewController: rootViewController)
            navigationController.isNavigationBarHidden = true
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            self.window = window
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
