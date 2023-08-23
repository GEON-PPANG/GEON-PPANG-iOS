//
//  SearchResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/14.
//

import Foundation

// MARK: - SearchResponseDTO

struct SearchResponseDTO: Decodable, Hashable {
    
    let resultCount: Int
    let bakeryList: [SearchBakeryList]

}

// MARK: - SearchBakeryList

struct SearchBakeryList: Decodable, Hashable, BakeryListProtocol {
    
    let bakeryID: Int
    let bakeryName: String
    let bakeryPicture: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let station: String
    let bookmarkCount: Int
    let reviewCount: Int
    let breadType: BreadResponseType
    
    private enum CodingKeys: String, CodingKey {
        case bakeryID = "bakeryId"
        case bakeryName, bakeryPicture
        case isHACCP, isVegan, isNonGMO
        case firstNearStation, secondNearStation
        case bookmarkCount = "bookMarkCount"
        case reviewCount
        case breadType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bakeryID = try container.decode(Int.self, forKey: .bakeryID)
        bakeryName = try container.decode(String.self, forKey: .bakeryName)
        bakeryPicture = try container.decode(String.self, forKey: .bakeryPicture)
        bookmarkCount = try container.decode(Int.self, forKey: .bookmarkCount)
        reviewCount = try container.decode(Int.self, forKey: .reviewCount)
        
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
