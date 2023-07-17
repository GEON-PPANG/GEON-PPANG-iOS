//
//  HomeService.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

enum HomeService {
    case best
}

extension HomeService: TargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .best:
            return URLConstant.best
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .best:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .best:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return NetworkConstant.hasTokenHeader
        }
    }
}
