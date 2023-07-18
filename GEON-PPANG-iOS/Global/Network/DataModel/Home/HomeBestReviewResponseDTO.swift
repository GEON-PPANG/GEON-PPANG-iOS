//
//  HomeBestReviewResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import Foundation

// MARK: - HomeBestReviewResponseDTO

struct HomeBestReviewResponseDTO: Codable, Hashable {
    
    let bakeryId: Int
    let bakeryName: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let firstNearStation: String
    let secondNearStation: String?
    let isBookMarked: Bool
    let bookMarkCount: Int
    let bakeryPicture: String
    let reviewCount: Int
    let reviewText: String
    let firstMaxRecommendKeyword: String
    let secondMaxRecommendKeyword: String?
    
    func convertToBakeryReviews() -> BestReviews {
        return BestReviews(bakeryId: bakeryId, bakeryName: bakeryName, isHACCP: isHACCP, isVegan: isVegan, isNonGMO: isNonGMO, firstNearStation: firstNearStation, secondNearStation: secondNearStation, isBookMarked: isBookMarked, bookMarkCount: bookMarkCount, bakeryPicture: bakeryPicture, reviewCount: reviewCount, reviewText: reviewText, firstMaxRecommendKeyword: firstMaxRecommendKeyword, secondMaxRecommendKeyword: secondMaxRecommendKeyword)
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
    
    let bakeryId: Int
    let bakeryName: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let firstNearStation: String
    let secondNearStation: String?
    let isBookMarked: Bool
    let bookMarkCount: Int
    let bakeryPicture: String
    let reviewCount: Int
    let reviewText: String
    let firstMaxRecommendKeyword: String
    let secondMaxRecommendKeyword: String?

}
