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
    case accessAndRefresh
}

extension KeychainKey {
    var label: String {
        switch self {
        case .access: return "accessToken"
        case .refresh: return "refreshToken"
        case .accessAndRefresh: return "accessAndRefreshToken"
        }
    }
}
