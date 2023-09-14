//
//  FilterService.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

enum FilterService {
    case changeFilter(_ requestData: FilterRequestDTO)
    case getFilterType
}

extension FilterService: TargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .changeFilter, .getFilterType:
            return URLConstant.changeFilter
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .changeFilter:
            return .post
        case .getFilterType:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .changeFilter(requestData: let data):
            return .requestJSONEncodable(data)
        case .getFilterType:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .changeFilter:
            return NetworkConstant.header(.accessToken)
        case .getFilterType:
            return NetworkConstant.header(.noToken)
        }
    }
    
}
