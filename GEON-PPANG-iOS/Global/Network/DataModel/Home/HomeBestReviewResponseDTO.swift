//
//  HomeBestReviewResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

// MARK: - HomeBestReviewResponseDTO

struct HomeBestReviewResponseDTO: Codable, Hashable {
    
    let bakeryId: Int
    let bakeryName: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let firstNearStation: String
    let secondNearStation: String?
    let isBooked: Bool
    let bookMarkCount: Int
    let bakeryPicture: String
    let reviewCount: Int
    let reviewText: String
    let firstMaxRecommendKeyword: String
    let secondMaxRecommendKeyword: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case bakeryID = "bakeryId"
//        case bakeryName, bakeryPicture, isHACCP, isVegan, isNonGMO, firstNearStation, secondNearStation, isBooked, bookMarkCount, reviewCount, firstMaxRecommendKeyword, secondMaxRecommendKeyword
//    }
}
