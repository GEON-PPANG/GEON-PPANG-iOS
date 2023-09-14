//
//  HomeService.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

enum HomeService {
    case bestBakery
    case bestReviews
}

extension HomeService: TargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .bestBakery:
            return URLConstant.bestBakery
        case.bestReviews:
            return URLConstant.bestReviews
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .bestBakery, .bestReviews:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .bestBakery, .bestReviews:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return NetworkConstant.header(.accessToken)
        }
    }
}
