//
//  SearchService.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

enum SearchService {
    case searchBakery(bakeryName: String)
}

extension SearchService: TargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .searchBakery:
            return URLConstant.search
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchBakery:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .searchBakery(bakeryName: let bakeryName):
            return .requestParameters(parameters: ["searchTerm": bakeryName], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return NetworkConstant.hasTokenHeader
        }
    }
}
