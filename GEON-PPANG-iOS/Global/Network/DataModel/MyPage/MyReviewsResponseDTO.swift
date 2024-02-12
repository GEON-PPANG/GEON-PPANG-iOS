//
//  MyReviewsResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/19.
//

import Foundation

// MARK: - MyReviewsResponseDTO

struct MyReviewsResponseDTO: Decodable, Equatable {
    
    let bakeryID: Int
    let name: String
    let picture: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let station: String
    let breadTypeList: [BreadType]
    let createdAt: String
    let reviewID: Int
    
    private enum CodingKeys: String, CodingKey {
        case bakeryID = "bakeryId"
        case name = "bakeryName"
        case picture = "bakeryPicture"
        case isHACCP, isVegan, isNonGMO
        case firstNearStation, secondNearStation
        case breadTypeList
        case reviewID = "reviewId"
        case createdAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bakeryID = try container.decode(Int.self, forKey: .bakeryID)
        name = try container.decode(String.self, forKey: .name)
        picture = try container.decode(String.self, forKey: .picture)
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
        
        breadTypeList = try container.decode([BreadType].self, forKey: .breadTypeList)
        reviewID = try container.decode(Int.self, forKey: .reviewID)
        createdAt = try container.decode(String.self, forKey: .createdAt)
    }
    
//    func hash(into hasher: inout Hasher) {
//        
//        hasher.combine(id)
//    }
    
    static func == (lhs: MyReviewsResponseDTO, rhs: MyReviewsResponseDTO) -> Bool {
        lhs.reviewID == rhs.reviewID
    }
    
//    let bakeries: [BookmarkBakeryListResponseDTO]
//    let createdAt: String
//    let reviewID: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case bakeries
//        case createdAt
//        case reviewID = "reviewId"
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.createdAt = try container.decode(String.self, forKey: .createdAt)
//        self.reviewID = try container.decode(Int.self, forKey: .reviewID)
//        self.bakeries = try container.decode([BookmarkBakeryListResponseDTO].self, forKey: .bakeries)
//
//    }
}
