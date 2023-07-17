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
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let firstNearStation: String
    let secondNearStation: String?
    let isBooked: Bool
    let bookmarkCount: Int
    let bakeryPicture: String
    let reviewCount: Int
}