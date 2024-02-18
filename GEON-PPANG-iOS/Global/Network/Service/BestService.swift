//
//  BestService.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

enum BestService {
    case bakery
    case reviews
}

extension BestService: GBService {
    
    var domain: GBDomain {
        return .best
    }
    
    var urlPath: String {
        switch self {
        case .bakery: return URLConstant.Best.bakeries
        case .reviews: return URLConstant.Best.reviews
        }
    }
    
    var headerType: GBHeaderFields {
        switch self {
        case .bakery, .reviews: return .optionalAccessToken
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .bakery, .reviews:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .bakery, .reviews:
            return .requestPlain
        }
    }
}
