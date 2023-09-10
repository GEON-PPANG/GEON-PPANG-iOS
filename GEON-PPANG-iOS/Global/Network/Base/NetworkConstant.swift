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
}
