//
//  HomeBestReviewResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import Foundation

// MARK: - HomeBestReviewResponseDTO

struct HomeBestReviewResponseDTO: Codable, Hashable {
    
    let bakeryID: Int
    let bakeryName: String
    let bakeryPicture: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let firstNearStation: String
    let secondNearStation: String?
    let isBookmarked: Bool
    let bookmarkCount: Int
    let reviewCount: Int
    let reviewText: String
    let firstMaxRecommendKeyword: String
    let secondMaxRecommendKeyword: String?
    
    enum CodingKeys: String, CodingKey {
        case bakeryID = "breadId"
        case bakeryName, bakeryPicture
        case isHACCP, isVegan, isNonGMO
        case firstNearStation, secondNearStation
        case isBookmarked = "isBookMarked"
        case bookmarkCount = "bookMarkCount"
        case reviewCount, reviewText
        case firstMaxRecommendKeyword, secondMaxRecommendKeyword
    }
    
    func convertToBakeryReviews() -> BestReviews {
        return BestReviews(bakeryID: bakeryID,
                           bakeryName: bakeryName,
                           isHACCP: isHACCP,
                           isVegan: isVegan,
                           isNonGMO: isNonGMO,
                           firstNearStation: firstNearStation,
                           secondNearStation: secondNearStation,
                           isBookmarked: isBookmarked,
                           bookmarkCount: bookmarkCount,
                           bakeryPicture: bakeryPicture,
                           reviewCount: reviewCount,
                           reviewText: reviewText,
                           firstMaxRecommendKeyword: firstMaxRecommendKeyword,
                           secondMaxRecommendKeyword: secondMaxRecommendKeyword)
    }
}

struct BestReviews: Codable, Hashable {
    var id = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: BestReviews, rhs: BestReviews) -> Bool {
        lhs.id == rhs.id
    }
    
    let bakeryID: Int
    let bakeryName: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let firstNearStation: String
    let secondNearStation: String?
    let isBookmarked: Bool
    let bookmarkCount: Int
    let bakeryPicture: String
    let reviewCount: Int
    let reviewText: String
    let firstMaxRecommendKeyword: String
    let secondMaxRecommendKeyword: String?
}
