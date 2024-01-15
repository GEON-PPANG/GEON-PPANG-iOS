//
//  BakeriesService.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

enum BakeriesService {
    case bakeryList(request: BakeryRequestDTO)
    case fetchBakeryDetail(bakeryID: Int)
    case fetchWrittenReviews(bakeryID: Int)
}

extension BakeriesService: GBService {
    var domain: GBDomain {
        return .bakeries
    }
    
    var urlPath: String {
        switch self {
        case .bakeryList:
            return ""
        case .fetchBakeryDetail(bakeryID: let bakeryID):
            return "/\(bakeryID)"
        case .fetchWrittenReviews(bakeryID: let bakeryID):
            return "/\(bakeryID)" + "/reviews"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .bakeryList:
            return .get
        case .fetchBakeryDetail:
            return .get
        case .fetchWrittenReviews:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .bakeryList(request: let request):
            return .requestParameters(parameters: try! request.asParameter(), encoding: URLEncoding.default)
        case .fetchBakeryDetail:
            return .requestPlain
        case .fetchWrittenReviews:
            return .requestPlain
        }
    }
    
    var headerType: GBHeaderFields {
        return .accessToken
    }
}
