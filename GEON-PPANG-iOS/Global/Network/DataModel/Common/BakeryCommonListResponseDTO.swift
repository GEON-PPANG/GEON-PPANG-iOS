//
//  BakeryCommonListResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/08/26.
//

import Foundation

struct BakeryCommonListResponseDTO: Decodable, Hashable, BakeryListProtocol {
    
    var id = UUID()
    let bakeryID: Int
    let name: String
    let picture: String
    let mark: CertificationMarkResponseType
    let station: String
    let bookmarkCount: Int
    let reviewCount: Int
    let breadType: BreadResponseType
    
    private enum CodingKeys: String, CodingKey {
        case bakeryID = "bakeryId"
        case name = "bakeryName"
        case picture = "bakeryPicture"
        case firstNearStation, secondNearStation
        case bookmarkCount = "bookMarkCount"
        case reviewCount, mark, breadType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bakeryID = try container.decode(Int.self, forKey: .bakeryID)
        name = try container.decode(String.self, forKey: .name)
        picture = try container.decode(String.self, forKey: .picture)
        bookmarkCount = try container.decode(Int.self, forKey: .bookmarkCount)
        reviewCount = try container.decode(Int.self, forKey: .reviewCount)
        
        let first = try container.decode(String.self, forKey: .firstNearStation)
        let second = try container.decode(String.self, forKey: .secondNearStation)
        
        if second == "" {
            station = "\(first)"
        } else {
            station = "\(first) ⦁ \(second)"
        }
        
        breadType = try container.decode(BreadResponseType.self, forKey: .breadType)
        mark = try CertificationMarkResponseType(from: decoder)
        
    }
    
    func hash(into hasher: inout Hasher) {
        
        hasher.combine(id)
    }
    
    static func == (lhs: BakeryCommonListResponseDTO, rhs: BakeryCommonListResponseDTO) -> Bool {
        lhs.id == rhs.id
    }
    
}
