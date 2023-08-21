//
//  SearchResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/14.
//

import Foundation

// MARK: - SearchResponseDTO

struct SearchResponseDTO: Codable, Hashable {
    let resultCount: Int
    let bakeryList: [SearchBakeryList]
}

// MARK: - SearchBakeryList

struct SearchBakeryList: Codable, Hashable, BakeryListProtocol {
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
    
    enum CodingKeys: String, CodingKey {
        case bakeryID = "breadId"
        case bakeryName, bakeryPicture
        case isHACCP, isVegan, isNonGMO
        case firstNearStation, secondNearStation
        case isBookmarked = "isBookMarked"
        case bookmarkCount = "bookMarkCount"
        case reviewCount
        case breadType
    }
    
}
