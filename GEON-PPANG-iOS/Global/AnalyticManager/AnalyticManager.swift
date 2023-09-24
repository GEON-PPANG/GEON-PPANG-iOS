//
//  AnalyticManager.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/09/15.
//

import Amplitude

enum AnalyticManager: AnalyticManagerProtocol {
    
    static func initialize() {
        
        Amplitude.instance().initializeApiKey(Config.amplitudeAPIKey)
    }
    
    /// user property

    static func set(userId: Int) {
        
        Amplitude.instance().setUserId(String(userId))
        
#if DEBUG
        print("🍥🍥🍥🍥🍥 userId: \(userId) 🍥🍥🍥🍥🍥")
#endif
    }

    static func log(event: AnalyticManagerEvent) {
        
        let name = event.name
        let parameters = event.parameters
        
        Amplitude.instance().logEvent(name, withEventProperties: parameters)
        
#if DEBUG
        if let parameters {
            let params = parameters.compactMap { $0 }
            print("🍥🍥🍥🍥🍥 \(name) \(params) 🍥🍥🍥🍥🍥")
            return
        }
        print("🍥🍥🍥🍥🍥🍥 \(name) 🍥🍥🍥🍥🍥")
#endif
        
    }
}
