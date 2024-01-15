//
//  ReviewsService.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

enum ReviewsService {
    case writeReview(bakeryID: Int, content: WriteReviewRequestDTO)
    case fetchMyReviewDetail(reviewID: Int)
}

extension ReviewsService: GBService {
    var domain: GBDomain {
        return .reviews
    }
    
    var urlPath: String {
        switch self {
        case .writeReview(bakeryID: let bakeryID, _):
            return "\(bakeryID)"
        case .fetchMyReviewDetail(let reviewID):
            return "\(reviewID)"
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
        case .fetchMyReviewDetail(let reviewID):
            return .requestPlain
        }
    }
    
    var headerType: GBHeaderFields {
        switch self {
        case .writeReview:
            return .accessToken
        case .fetchMyReviewDetail:
            return .accessToken
        }
    }
    
}
