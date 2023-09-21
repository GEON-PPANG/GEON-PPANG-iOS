//
//  Config.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

enum Config {
    
    enum Keys {
        enum Plist {
            static let baseURL = "BASE_URL"
            static let sentryAPIKey = "SENTRY_API_KEY"
            static let kakaoNativeAppKey = "NATIVE_APP_KEY"
            static let amplitudeAPIKey = "AMPLITUDE_API_KEY"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("✅plist cannot found.✅")
        }
        return dict
    }()
}

extension Config {
    
    static let baseURL: String = {
        guard let key = Config.infoDictionary[Keys.Plist.baseURL] as? String else {
            fatalError("✅Base URL is not set in plist for this configuration.✅")
        }
        return key
    }()
    
    static let sentryAPIKey: String = {
        guard let key = Config.infoDictionary[Keys.Plist.sentryAPIKey] as? String else {
            fatalError("✅SENTRY_API_KEY is not set in plist for this configuration.✅")
        }
        return key
    }()
    
    static let kakaoNativeAppKey: String = {
        guard let key = Config.infoDictionary[Keys.Plist.kakaoNativeAppKey] as? String else {
            fatalError("✅kakaoNativeAppKey is not set in plist for this configuration.✅")
        }
        return key
    }()
    
    static let amplitudeAPIKey: String = {
        guard let key = Config.infoDictionary[Keys.Plist.amplitudeAPIKey] as? String else {
            fatalError("✅amplitudeAPIKey is not set in plist for this configuration.✅")
        }
        return key
    }()
}
