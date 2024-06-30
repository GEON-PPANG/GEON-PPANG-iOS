//
//  MemberEndpoint.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 6/27/24.
//

import Foundation

import GBNetwork

enum MemberEndpoint {
    case postFilter(request: PostFilterRequestDTO)
}

extension MemberEndpoint: RequestType {
    var baseURL: String {
        return ""
    }
    
    var path: String {
        switch self {
        case .postFilter: "/member/types"
        }
    }
    
    var method: GBNetwork.HTTPMethod {
        switch self {
        case .postFilter: .POST
        }
    }
    
    var task: GBNetwork.HTTPTask {
        switch self {
        case let .postFilter(body): .requestEncodable(body)
        }
    }
    
    var headers: GBNetwork.HTTPHeader {
        switch self {
        case .postFilter:
                .init(headers: [
                    .contentType(value: "application/json"),
                    .accessToken(value: "")
                ])
        }
    }
}
