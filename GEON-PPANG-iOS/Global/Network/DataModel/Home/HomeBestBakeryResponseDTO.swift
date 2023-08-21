//
//  HomeBestBakeryResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

struct HomeBestBakeryResponseDTO: Codable, Hashable {
    
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
    
    enum CodingKeys: String, CodingKey {
        case bakeryID = "breadId"
        case bakeryName, bakeryPicture
        case isHACCP, isVegan, isNonGMO
        case firstNearStation, secondNearStation
        case isBookmarked = "isBookMarked"
        case bookmarkCount = "bookMarkCount"
        case reviewCount
    }
    
    func convertToBestBakery() -> BestBakery {
        return BestBakery(bakeryID: bakeryID,
                          bakeryName: bakeryName,
                          bakeryPicture: bakeryPicture,
                          isHACCP: isHACCP,
                          isVegan: isVegan,
                          isNonGMO: isNonGMO,
                          firstNearStation: firstNearStation,
                          secondNearStation: secondNearStation,
                          isBookmarked: isBookmarked,
                          bookmarkCount: bookmarkCount,
                          reviewCount: reviewCount)
    }
    
}

struct BestBakery: Codable, Hashable {
    var id = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: BestBakery, rhs: BestBakery) -> Bool {
        lhs.id == rhs.id
    }
    
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
    
}
