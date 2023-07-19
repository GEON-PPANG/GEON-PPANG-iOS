//
//  BakeryListResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/11.
//

import Foundation

// MARK: - BakeryListResponseDTO

struct BakeryListResponseDTO: Codable, Hashable, BakeryListProtocol {

    let bakeryId: Int
    let bakeryName: String
    let bakeryPicture: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let firstNearStation: String
    var secondNearStation: String?
    let isBookMarked: Bool
    let bookMarkCount: Int
    let reviewCount: Int
    let breadType: BreadResponseType

    func convertToBakeryList() -> BakeryList {
        return BakeryList(bakeryId: bakeryId, bakeryName: bakeryName, bakeryPicture: bakeryPicture, isHACCP: isHACCP, isVegan: isVegan, isNonGMO: isNonGMO, firstNearStation: firstNearStation, secondNearStation: secondNearStation, isBookMarked: isBookMarked, bookMarkCount: bookMarkCount, reviewCount: reviewCount, breadType: breadType)
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
    let breadType: BreadResponseType

}
