//
//  MyReviewDetailResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/09/07.
//

import Foundation

struct MyReviewDetailResponseDTO: Codable {
    
    let reviewID: Int
    let recommendKeywordList: [RecommendKeywordList]
    let reviewText: String
    let isLike: Bool

    enum CodingKeys: String, CodingKey {
        case reviewID = "reviewId"
        case recommendKeywordList, reviewText, isLike
    }
}
