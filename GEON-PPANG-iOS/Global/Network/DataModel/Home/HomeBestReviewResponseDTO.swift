//
//  HomeBestReviewResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import Foundation

// MARK: - HomeBestReviewResponseDTO

struct HomeBestReviewResponseDTO: Codable, Hashable {
    
    var id = UUID()

    let bakeryID: Int
    let name: String
    let picture: String
    let mark: CertificationMarkResponseType
    let keywords: RecomendKeywordResponseDTO
    let bookmarkCount: Int
    let reviewCount: Int
    let text: String
    
    private enum CodingKeys: String, CodingKey {
        case bakeryID = "bakeryId"
        case name = "bakeryName"
        case picture = "bakeryPicture"
        case mark, keywords
        case bookmarkCount = "bookMarkCount"
        case reviewCount
        case text = "reviewText"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bakeryID = try container.decode(Int.self, forKey: .bakeryID)
        name = try container.decode(String.self, forKey: .name)
        picture = try container.decode(String.self, forKey: .picture)
        bookmarkCount = try container.decode(Int.self, forKey: .bookmarkCount)
        reviewCount = try container.decode(Int.self, forKey: .reviewCount)
        text = try container.decode(String.self, forKey: .text)
        mark = try CertificationMarkResponseType(from: decoder)
        keywords = try RecomendKeywordResponseDTO(from: decoder)
    }
        
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: HomeBestReviewResponseDTO, rhs: HomeBestReviewResponseDTO) -> Bool {
        lhs.id == rhs.id
    }
}
