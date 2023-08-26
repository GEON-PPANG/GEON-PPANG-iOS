//
//  HomeCommonResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/08/21.
//

import Foundation

struct HomeCommonResponseDTO: Hashable, Codable {
    
    let bakeryID: Int
    let name: String
    let picture: String
    let mark: CertificationMarkResponseType
    let station: NearStationResponseDTO
    let bookmarkCount: Int
    let reviewCount: Int
    
    enum CodingKeys: String, CodingKey {
        
        case bakeryID = "bakeryId"
        case name = "bakeryName"
        case picture = "bakeryPicture"
        case bookmarkCount = "bookMarkCount"
        case reviewCount
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bakeryID = try container.decode(Int.self, forKey: .bakeryID)
        name = try container.decode(String.self, forKey: .name)
        picture = try container.decode(String.self, forKey: .picture)
        bookmarkCount = try container.decode(Int.self, forKey: .bookmarkCount)
        reviewCount = try container.decode(Int.self, forKey: .reviewCount)
        mark = try CertificationMarkResponseType(from: decoder)
        station = try NearStationResponseDTO(from: decoder)
    }
}
