//
//  BakeryService.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

enum BakeryService {
    case bakeryList(sort: String, isHard: Bool, isDessert: Bool, isBrunch: Bool)
    case writeReview(bakeryID: Int, content: WriteReviewDTO)
}

extension BakeryService: TargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .bakeryList:
            return URLConstant.bakeryList
        case .writeReview(bakeryID: let bakeryID, _):
            return URLConstant.writeReview + "/\(bakeryID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .bakeryList:
            return .get
        case .writeReview:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .bakeryList(sort: let sort, isHard: let isHard, isDessert: let isDessert, isBrunch: let isBrunch):
            return .requestParameters(parameters: ["sort": sort,
                                                   "isHard": isHard,
                                                   "isDessert": isDessert,
                                                   "isBrunch": isBrunch
                                                  ],
                                      encoding: URLEncoding.queryString)
        case .writeReview(_, content: let content):
            return .requestJSONEncodable(content)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return NetworkConstant.hasTokenHeader
        }
    }
}
