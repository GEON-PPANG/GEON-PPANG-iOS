//
//  BakeryListResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/11.
//

import Foundation

// MARK: - BakeryListResponseDTO

struct BakeryListResponseDTO: Codable, Hashable, BakeryListProtocol {

    let bakeryID: Int
    let bakeryName: String
    let bakeryPicture: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let firstNearStation: String
    var secondNearStation: String?
    let isBookmarked: Bool
    let bookmarkCount: Int
    let reviewCount: Int
    let breadType: BreadResponseType

    func convertToBakeryList() -> BakeryList {
        return BakeryList(bakeryID: bakeryID,
                          bakeryName: bakeryName,
                          bakeryPicture: bakeryPicture,
                          isHACCP: isHACCP,
                          isVegan: isVegan,
                          isNonGMO: isNonGMO,
                          firstNearStation: firstNearStation,
                          secondNearStation: secondNearStation,
                          isBookmarked: isBookmarked,
                          bookmarkCount: bookmarkCount,
                          reviewCount: reviewCount,
                          breadType: breadType)
    }
}

struct BakeryList: Codable, Hashable, BakeryListProtocol {
    
    var id = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: BakeryList, rhs: BakeryList) -> Bool {
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
    let breadType: BreadResponseType

}
