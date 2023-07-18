//
//  BakeryService.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

enum BakeryService {
    case writeReview(bakeryID: String)
}

extension BakeryService: TargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .writeReview:
            return URLConstant.writeReview
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .writeReview:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .writeReview(bakeryID: let bakeryID):
            return .requestParameters(parameters: ["bakeryID": bakeryID], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return NetworkConstant.hasTokenHeader
        }
    }
}
