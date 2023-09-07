//
//  BakeryService.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

import Moya

enum BakeryService {
    case bakeryList(request: BakeryRequestDTO)
    case fetchBakeryDetail(bakeryID: Int)
    case fetchWrittenReviews(bakeryID: Int)
    case bookmark(bakeryID: Int, request: BookmarkRequestDTO)
}

extension BakeryService: TargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .bakeryList:
            return URLConstant.bakeryList
        case .fetchBakeryDetail(bakeryID: let bakeryID):
            return URLConstant.bakeryList + "/\(bakeryID)"
        case .fetchWrittenReviews(bakeryID: let bakeryID):
            return URLConstant.bakeryList + "/\(bakeryID)" + "/reviews"
        case .bookmark(bakeryID: let bakeryID, _):
            return URLConstant.bookmark + "/\(bakeryID)"
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
        case .bookmark:
            return .post
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
        case .bookmark(_, request: let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return NetworkConstant.hasTokenHeader
        }
    }
}
