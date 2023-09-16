//
//  AnalyticManagerEventProtocol.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/09/15.
//

import Foundation

protocol AnalyticManagerEventProtocol {
    
    var name: String { get }
    
    var parameters: [String: Any]? { get }
}

extension AnalyticManagerEventProtocol {
    
    var parameters: [String: Any]? { nil }
}
