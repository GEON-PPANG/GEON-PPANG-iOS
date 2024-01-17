//
//  ReviewsService.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 1/15/24.
//

import Foundation

import Moya

enum ReviewsService {
    case write(bakeryID: Int, content: WriteReviewRequestDTO)
    case myReview(reviewID: Int)
}

extension ReviewsService: GBService {
    var domain: GBDomain {
        return .reviews
    }
    
    var urlPath: String {
        switch self {
        case .write(bakeryID: let bakeryID, _):
            return "\(bakeryID)"
        case .myReview(let reviewID):
            return "\(reviewID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .write:
            return .post
        case .myReview:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .write(_, content: let content):
            return .requestJSONEncodable(content)
        case .myReview(let reviewID):
            return .requestPlain
        }
    }
    
    var headerType: GBHeaderFields {
        switch self {
        case .write:
            return .accessToken
        case .myReview:
            return .accessToken
        }
    }
    
}
