//
//  HTTPHeader.swift
//  GBNetwork
//
//  Created by 이성민 on 6/29/24.
//

import Foundation

public struct HTTPHeader {
    private(set) var headers: [HTTPHeaderField] = []
    
    public init(headers: [HTTPHeaderField]) {
        self.headers = headers
    }
}

extension HTTPHeader {
    var fields: [String: String] {
        .init(uniqueKeysWithValues: headers.map { ($0.key, $0.value) })
    }
}

public struct HTTPHeaderField {
    let key: String
    let value: String
}

public extension HTTPHeaderField {
    static func contentType(value: String) -> HTTPHeaderField {
        .init(key: "Content-Type", value: value)
    }
    
    static func accessToken(value: String) -> HTTPHeaderField {
        .init(key: "Authorization", value: "Bearer \(value)")
    }
    
    static func refreshToken(value: String) -> HTTPHeaderField {
        .init(key: "Authorization-refresh", value: "Bearer \(value)")
    }
    
    static func appleRefreshToken(value: String) -> HTTPHeaderField {
        .init(key: "Apple-refresh", value: value)
    }
    
    static func platformToken(value: String) -> HTTPHeaderField {
        .init(key: "Platform-Token", value: value)
    }
}
