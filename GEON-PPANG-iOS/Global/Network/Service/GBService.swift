//
//  GBAPI.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

enum GBDomain {
    case auth
    case validation
    case report
    case best
    case bookmarks
    case member
    case search
    case bakeries
    case reviews
}

extension GBDomain {
    var url: String {
        switch self {
        case .auth: return "/auth"
        case .validation: return "/validation"
        case .report: return "/report"
        case .best: return "/best"
        case .bookmarks: return "/bookMarks"
        case .member: return "/member"
        case .search: return "/search"
        case .bakeries: return "/bakeries"
        case .reviews: return "/reviews"
        }
    }
}

enum GBHeaderFields {
    case noToken
    case platformToken
    case accessToken
    case accessAndRefreshToken
    case appleRefresh
}

protocol GBService: TargetType {
    var domain: GBDomain { get }
    var urlPath: String { get }
    var headerType: GBHeaderFields { get }
}

extension GBService {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        return domain.url + urlPath
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var headers: [String: String]? {
        switch headerType {
        case .noToken: return NetworkConstant.header(.noToken)
        case .platformToken: return NetworkConstant.header(.platformToken)
        case .accessToken: return NetworkConstant.header(.accessToken)
        case .accessAndRefreshToken: return NetworkConstant.header(.accessAndRefreshToken)
        case .appleRefresh: return NetworkConstant.header(.appleRefresh)
        }
    }
}
