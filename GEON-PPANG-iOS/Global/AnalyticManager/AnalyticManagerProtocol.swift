//
//  AmplitudeEventProtocol.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/09/14.
//

import Amplitude

protocol AnalyticManagerProtocol {
    
    static func log(event: AnalyticManagerEvent)
}
