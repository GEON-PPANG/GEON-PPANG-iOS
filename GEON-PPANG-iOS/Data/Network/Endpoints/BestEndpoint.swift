//
//  BestEndpoint.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 6/29/24.
//

import Foundation

import GBNetwork

enum BestEndpoint {
    case getBestBakeries
    case getBestReviews
}

extension BestEndpoint: RequestType {
    var baseURL: String {
        return Config.baseURL
    }
    
    var path: String {
        switch self {
        case .getBestBakeries: "/best/bakeries"
        case .getBestReviews: "/best/reviews"
        }
    }
    
    var method: GBNetwork.HTTPMethod {
        switch self {
        case .getBestBakeries: .GET
        case .getBestReviews: .GET
        }
    }
    
    var task: GBNetwork.HTTPTask {
        switch self {
        case .getBestBakeries: .requestPlain
        case .getBestReviews: .requestPlain
        }
    }
    
    var headers: HTTPHeader {
        switch self {
        case .getBestBakeries, .getBestReviews:
            return .init(headers: [
                .contentType(value: "application/json"), .optionalToken(value: nil)
            ])
        }
    }
}
