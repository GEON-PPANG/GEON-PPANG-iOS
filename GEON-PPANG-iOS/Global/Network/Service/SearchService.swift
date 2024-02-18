//
//  SearchService.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

enum SearchService {
    case bakeries(bakeryName: String)
}

extension SearchService: GBService {
    var domain: GBDomain {
        return .search
    }
    
    var urlPath: String {
        switch self {
        case .bakeries:
            return "/bakeries"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .bakeries:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .bakeries(let bakeryName):
            return .requestParameters(parameters: ["searchTerm": bakeryName],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headerType: GBHeaderFields {
        switch self {
        case .bakeries:
            return .optionalAccessToken
        }
    }
    
}
