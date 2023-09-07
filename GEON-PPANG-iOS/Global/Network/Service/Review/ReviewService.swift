//
//  ReviewService.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/09/07.
//

import Foundation

import Moya

enum ReviewService {
    case writeReview(bakeryID: Int, content: WriteReviewRequestDTO)
    case fetchMyReviewDetail(reviewID: Int)
}

extension ReviewService: TargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .writeReview(bakeryID: let bakeryID, _):
            return URLConstant.review + "/\(bakeryID)"
        case .fetchMyReviewDetail(reviewID: let reviewID):
            return URLConstant.review + "\(reviewID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .writeReview:
            return .post
        case .fetchMyReviewDetail:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .writeReview(_, content: let content):
            return .requestJSONEncodable(content)
        case .fetchMyReviewDetail:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return NetworkConstant.hasTokenHeader
        }
    }
}

