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
    var id: Int { bakeryId }
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
    var breadType: BreadResponseType

}
