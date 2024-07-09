//
//  BestReviewDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 6/29/24.
//

import Foundation

struct BestReviewResponseDTO: Decodable {
    let bakeryID: Int
    let bakeryName: String
    let bakeryPicture: String
    let isHACCP, isVegan, isNonGMO: Bool
    let firstNearStation, secondNearStation: String
    let reviewCount: Int
    let reviewText: String
    let firstMaxRecommendKeyword: String
    let secondMaxRecommendKeyword: String?
    let bookMarkCount: Int
    
    enum CodingKeys: String, CodingKey {
        case bakeryID = "bakeryId"
        case bakeryName, bakeryPicture, isHACCP, isVegan, isNonGMO, firstNearStation, secondNearStation, reviewCount, reviewText, firstMaxRecommendKeyword, secondMaxRecommendKeyword, bookMarkCount
    }
}

extension BestReviewResponseDTO {
    
    func toDomain() -> BestReview {
        let overview: BakeryOverview = .init(id: bakeryID, name: bakeryName, image: bakeryPicture)
        
        return BestReview(overview: overview,
                          reviewOverview: reviewText,
                          recommendKeywords: [firstMaxRecommendKeyword, secondNearStation],
                          bookmarkCount: bookMarkCount,
                          reviewCount: reviewCount)
    }
}
