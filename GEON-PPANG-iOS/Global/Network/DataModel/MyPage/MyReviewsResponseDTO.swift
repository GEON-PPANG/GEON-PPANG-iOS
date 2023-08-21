//
//  MyReviewsResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/19.
//

import Foundation

// MARK: - MyReviewsResponseDTO

struct MyReviewsResponseDTO: Codable {
    let bakeryID: Int
    let bakeryName: String
    let bakeryPicture: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let firstNearStation: String
    let secondNearStation: String?
    let isBookmarked: Bool?
    let bookmarkCount: Int?
    let reviewID: Int
    let breadType: BreadResponseType
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case bakeryID = "bakeryId"
        case bakeryName, bakeryPicture
        case isHACCP, isVegan, isNonGMO
        case firstNearStation, secondNearStation
        case isBookmarked = "isBookMarked"
        case bookmarkCount = "bookMarkCount"
        case reviewID = "reviewId"
        case breadType
        case createdAt
    }
}
