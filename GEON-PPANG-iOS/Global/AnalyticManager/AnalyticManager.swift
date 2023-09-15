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

    static func log(user: AnalyticManagerUser, value: Any) {
        
        guard let identify = AMPIdentify().set(user.name, value: value as? NSObject) else { return }
            Amplitude.instance().identify(identify)
        
#if DEBUG
            print("🍥🍥🍥🍥🍥 \(user.name): \(value) 🍥🍥🍥🍥🍥")
#endif
    }
    
    /// user property only once
    
    static func logOnce(user: AnalyticManagerUser, value: Any) {
        
        guard let identify  = AMPIdentify().setOnce(user.name, value: value as? NSObject) else { return }
        Amplitude.instance().identify(identify)
        
#if DEBUG
            print("🍥🍥🍥🍥🍥 \(user.name): \(value) 🍥🍥🍥🍥🍥")
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

//
//AMPIdentify().setOnce("sign_up_date", value: "2015-08-24")
//Amplitude.instance().identify(identify1)
//
//let identify = AMPIdentify()
//    .add("karma", value: NSNumber(value: 0.123))
//    .add("friends",value: NSNumber(value: 1))
//Amplitude.instance().identify(identify)
