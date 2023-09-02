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
            static let accessToken = "ACCESS_TOKEN"
            static let kakaoNativeAppKey = "NATIVE_APP_KEY"
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
    
    static let accessToken: String = {
        guard let key = Config.infoDictionary[Keys.Plist.accessToken] as? String else {
            fatalError("✅accessToken is not set in plist for this configuration.✅")
        }
        return key
    }()
    
    static let kakaoNativeAppKey: String = {
        guard let key = Config.infoDictionary[Keys.Plist.kakaoNativeAppKey] as? String else {
            fatalError("✅kakaoNativeAppKey is not set in plist for this configuration.✅")
        }
        return key
    }()
}
