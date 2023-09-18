//
//  AppDelegate.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/06/21.
//

import UIKit

import FirebaseCore

import KakaoSDKCommon

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        AnalyticManager.initialize()
        KakaoSDK.initSDK(appKey: Config.kakaoNativeAppKey)
        sleep(UInt32(1.5))
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    // 앱이 최초 실행될 때 호출되는 메소드
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        AnalyticManager.log(event: .general(.openApp))
        return true
    }
    
    // 앱이 종료되기 직전에 호출되는 메소드
    
    func applicationWillTerminate(_ application: UIApplication) {
        AnalyticManager.log(event: .general(.closeApp))
    }
}
