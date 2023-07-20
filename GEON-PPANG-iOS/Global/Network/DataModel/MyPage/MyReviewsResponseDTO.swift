//
//  MyReviewsResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/19.
//

import Foundation

// MARK: - MyReviewsResponseDTO

struct MyReviewsResponseDTO: Codable {    
        
    let bakeryId: Int
    let bakeryName: String
    let bakeryPicture: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let firstNearStation: String
    let secondNearStation: String?
    let isBookMarked: Bool?
    let bookMarkCount: Int?
    let reviewID: Int
    let breadType: BreadResponseType
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case bakeryId = "bakeryId"
        case bakeryName, bakeryPicture, isHACCP, isVegan, isNonGMO, firstNearStation, secondNearStation, isBookMarked, bookMarkCount, breadType
        case reviewID = "reviewId"
        case createdAt
    }
}
