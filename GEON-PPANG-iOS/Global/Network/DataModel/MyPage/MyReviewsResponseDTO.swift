//
//  MyReviewsResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/19.
//

import Foundation

// MARK: - MyReviewsResponseDTO

struct MyReviewsResponseDTO: Decodable, BakeryListProtocol {
    var reviewCount: Int
    let bakeryID: Int
    let bakeryName: String
    let bakeryPicture: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let station: String
    var bookmarkCount: Int
    let reviewID: Int
    let breadType: BreadResponseType
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case bakeryID = "bakeryId"
        case bakeryName, bakeryPicture
        case isHACCP, isVegan, isNonGMO
        case firstNearStation, secondNearStation
        case bookmarkCount = "bookMarkCount"
        case reviewID = "reviewId"
        case breadType
        case createdAt
        case reviewCount
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bakeryID = try container.decode(Int.self, forKey: .bakeryID)
        bakeryName = try container.decode(String.self, forKey: .bakeryName)
        bakeryPicture = try container.decode(String.self, forKey: .bakeryPicture)
        bookmarkCount = try container.decode(Int.self, forKey: .bookmarkCount)
        reviewCount = try container.decode(Int.self, forKey: .reviewCount)
        reviewID = try container.decode(Int.self, forKey: .reviewID)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        
        isHACCP = try container.decode(Bool.self, forKey: .isHACCP)
        isVegan = try container.decode(Bool.self, forKey: .isVegan)
        isNonGMO = try container.decode(Bool.self, forKey: .isNonGMO)
        
        let first = try container.decode(String.self, forKey: .firstNearStation)
        let second = try container.decode(String.self, forKey: .secondNearStation)
        
        if second == "" {
            station = "\(first)"
        } else {
            station = "\(first) ⦁ \(second)"
        }
        
        breadType = try container.decode(BreadResponseType.self, forKey: .breadType)
        
    }
}
