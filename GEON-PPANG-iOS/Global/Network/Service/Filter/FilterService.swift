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
}

extension FilterService: TargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .changeFilter:
            return URLConstant.changeFilter
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .changeFilter:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .changeFilter(requestData: let data):
            return .requestJSONEncodable(data)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return NetworkConstant.hasTokenHeader
        }
    }
    
}
