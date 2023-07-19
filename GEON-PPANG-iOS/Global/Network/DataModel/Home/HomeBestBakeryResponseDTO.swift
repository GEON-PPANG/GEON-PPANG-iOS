//
//  HomeBestBakeryResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

struct HomeBestBakeryResponseDTO: Codable, Hashable {
    
    let bakeryId: Int
    let bakeryName: String
    let bakeryPicture: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let firstNearStation: String
    let secondNearStation: String?
    let isBookMarked: Bool
    let bookMarkCount: Int
    let reviewCount: Int
    
    func convertToBestBakery() -> BestBakery {
        return BestBakery(bakeryId: bakeryId, bakeryName: bakeryName, bakeryPicture: bakeryPicture, isHACCP: isHACCP, isVegan: isVegan, isNonGMO: isNonGMO, firstNearStation: firstNearStation, secondNearStation: secondNearStation, isBookMarked: isBookMarked, bookMarkCount: bookMarkCount, reviewCount: reviewCount)
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
    
    let bakeryId: Int
    let bakeryName: String
    let bakeryPicture: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let firstNearStation: String
    let secondNearStation: String?
    let isBookMarked: Bool
    let bookMarkCount: Int
    let reviewCount: Int
    
}
