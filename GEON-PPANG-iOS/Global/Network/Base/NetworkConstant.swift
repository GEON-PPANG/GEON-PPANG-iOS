//
//  NetworkConstant.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

struct NetworkConstant {
    static let noTokenHeader = ["Content-Type": "application/json"]
    static let hasTokenHeader = [
        "Content-Type": "application/json",
        "Authorization": "Bearer \(KeychainService.readKeychain(of: .access))"
    ]
    static let platformTokenHeader = [
        "Content-Type": "application/json",
        "Platform-token": KeychainService.readKeychain(of: .socialAuth)
    ]
    
    static func header(_ type: HeaderType) -> [String: String] {
        
        switch type {
        case .noToken:
            return ["Content-Type": "application/json"]
        case .platformToken:
            return ["Content-Type": "application/json",
                    "Platform-token": KeychainService.readKeychain(of: .socialAuth)]
        case .accessToken:
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer \(KeychainService.readKeychain(of: .access))"]
        case .accessAndRefreshToken:
            return ["Authorization": "Bearer \(KeychainService.readKeychain(of: .access))",
                    "Authorization-refresh": "Bearer \(KeychainService.readKeychain(of: .refresh))"]
        case .appleRefresh:
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer \(KeychainService.readKeychain(of: .access))",
                    "Apple-refresh": KeychainService.readKeychain(of: .appleRefresh)]
        }
    }
}
