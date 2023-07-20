//
//  WrittenReviewsResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/20.
//

import Foundation

// MARK: - WrittenReviewsResponseDTO
struct WrittenReviewsResponseDTO: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let tastePercent, specialPercent, kindPercent: Int
    let zeroPercent: Double
    let totalReviewCount: Int
    let reviewList: [ReviewList]
}

// MARK: - ReviewList
struct ReviewList: Codable {
    let reviewID: Int
    let recommendKeywordList: [RecommendKeywordList]
    let reviewText, memberNickname, createdAt: String

    enum CodingKeys: String, CodingKey {
        case reviewID = "reviewId"
        case recommendKeywordList, reviewText, memberNickname, createdAt
    }
}

// MARK: - RecommendKeywordList
struct RecommendKeywordList: Codable {
    let recommendKeywordID: Int
    let recommendKeywordName: String

    enum CodingKeys: String, CodingKey {
        case recommendKeywordID = "recommendKeywordId"
        case recommendKeywordName
    }
}
