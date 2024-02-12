//
//  BookmarkBakeryListResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2/11/24.
//

import Foundation

struct BookmarkBakeryListResponseDTO: Decodable, Hashable, BakeryListProtocol {
    
    var id = UUID()
    let bakeryID: Int
    let name: String
    let picture: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let station: String
    let bookmarkCount: Int
    let reviewCount: Int
    let breadTypeList: [BreadType]
    
    private enum CodingKeys: String, CodingKey {
        case bakeryID = "bakeryId"
        case name = "bakeryName"
        case picture = "bakeryPicture"
        case isHACCP, isVegan, isNonGMO
        case firstNearStation, secondNearStation
        case bookmarkCount = "bookMarkCount"
        case reviewCount, breadTypeList
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bakeryID = try container.decode(Int.self, forKey: .bakeryID)
        name = try container.decode(String.self, forKey: .name)
        picture = try container.decode(String.self, forKey: .picture)
        isHACCP = try container.decode(Bool.self, forKey: .isHACCP)
        isVegan = try container.decode(Bool.self, forKey: .isVegan)
        isNonGMO = try container.decode(Bool.self, forKey: .isNonGMO)
        bookmarkCount = (try? container.decode(Int.self, forKey: .bookmarkCount)) ?? 0
        reviewCount = (try? container.decode(Int.self, forKey: .reviewCount)) ?? 0
        
        let first = try container.decode(String.self, forKey: .firstNearStation)
        let second = try container.decode(String.self, forKey: .secondNearStation)
        
        if second == "" {
            station = "\(first)"
        } else {
            station = "\(first) ⦁ \(second)"
        }
        
        breadTypeList = try container.decode([BreadType].self, forKey: .breadTypeList)
        
    }
    
    func hash(into hasher: inout Hasher) {
        
        hasher.combine(id)
    }
    
    static func == (lhs: BookmarkBakeryListResponseDTO, rhs: BookmarkBakeryListResponseDTO) -> Bool {
        lhs.id == rhs.id
    }
}

extension BookmarkBakeryListResponseDTO {
    func toBooleanArray() -> [Bool] {
        return [isHACCP, isVegan, isNonGMO]
    }
}
