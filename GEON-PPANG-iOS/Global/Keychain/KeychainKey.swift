//
//  KeychainKey.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/09/08.
//

import Foundation

enum KeychainKey {
    case access
    case refresh
    case appleRefresh
    case socialAuth
    case userEmail
    case socialType
    case role
}

extension KeychainKey {
    var account: String {
        switch self {
        case .access: return "accessToken"
        case .refresh: return "refreshToken"
        case .appleRefresh: return "appleRefreshToken"
        case .socialAuth: return "socialAuthorizationCode"
        case .socialType: return "socialType"
        case .userEmail: return "userEmail"
        case .role: return "role"
        }
    }
}
