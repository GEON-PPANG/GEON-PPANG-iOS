//
//  BakeriesService.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

enum BakeriesService {
    case bakeries(request: BakeryRequestDTO)
    case bakeryDetail(bakeryID: Int)
    case bakeryReviews(bakeryID: Int)
}

extension BakeriesService: GBService {
    var domain: GBDomain {
        return .bakeries
    }
    
    var urlPath: String {
        switch self {
        case .bakeries:
            return ""
        case .bakeryDetail(bakeryID: let bakeryID):
            return "/\(bakeryID)"
        case .bakeryReviews(bakeryID: let bakeryID):
            return "/\(bakeryID)" + "/reviews"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .bakeries:
            return .get
        case .bakeryDetail:
            return .get
        case .bakeryReviews:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .bakeries(request: let request):
            return .requestParameters(parameters: try! request.asParameter(), encoding: URLEncoding.default)
        case .bakeryDetail:
            return .requestPlain
        case .bakeryReviews:
            return .requestPlain
        }
    }
    
    var headerType: GBHeaderFields {
        return .accessToken
    }
}
