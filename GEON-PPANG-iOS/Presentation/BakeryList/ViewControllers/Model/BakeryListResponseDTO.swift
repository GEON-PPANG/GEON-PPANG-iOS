//
//  BakeryListResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/11.
//

import Foundation

// MARK: - BakeryListResponseDTO

struct BakeryListResponseDTO: Codable, Hashable, BakeryListProtocol {
    let reviewCount: Int
    let bakeryID: Int
    let bakeryName: String
    let bakeryPicture: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let breadType: BreadResponseType
    let firstNearStation: String
    let secondNearStation: String?
    let isBookMarked: Bool
    let bookMarkCount: Int
    
    enum CodingKeys: String, CodingKey {
        case reviewCount
        case bakeryID = "bakeryId"
        case bakeryName
        case bakeryPicture
        case isHACCP
        case isVegan
        case isNonGMO
        case breadType
        case firstNearStation
        case secondNearStation
        case isBookMarked
        case bookMarkCount
    }
    
    func convertToBakeryList() -> BakeryList {
        return BakeryList(reviewCount: reviewCount, bakeryID: bakeryID, bakeryName: bakeryName, bakeryPicture: bakeryPicture, isHACCP: isHACCP, isVegan: isVegan, isNonGMO: isNonGMO, breadType: breadType, firstNearStation: firstNearStation, secondNearStation: secondNearStation, isBookMarked: isBookMarked, bookMarkCount: bookMarkCount)
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
    
    let reviewCount: Int
    let bakeryID: Int
    let bakeryName: String
    let bakeryPicture: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let breadType: BreadResponseType
    let firstNearStation: String
    let secondNearStation: String?
    let isBookMarked: Bool
    let bookMarkCount: Int
    
    enum CodingKeys: String, CodingKey {
        case reviewCount
        case bakeryID = "bakeryId"
        case bakeryName
        case bakeryPicture
        case isHACCP
        case isVegan
        case isNonGMO
        case breadType
        case firstNearStation
        case secondNearStation
        case isBookMarked
        case bookMarkCount
    }
    
}
