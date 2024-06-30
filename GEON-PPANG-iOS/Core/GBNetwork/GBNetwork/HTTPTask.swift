//
//  HTTPTask.swift
//  GBNetwork
//
//  Created by 이성민 on 6/29/24.
//

import Foundation

public enum HTTPTask {
    /// plain request
    case requestPlain
    /// request with query parameters
    case requestQuery(_ query: [String: Any])
    /// request with encodable body
    case requestEncodable(_ body: Encodable)
}
