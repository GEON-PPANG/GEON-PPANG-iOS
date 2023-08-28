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
    
    let reviews: HomeCommonResponseDTO
    let keywords: RecommendKeywordResponseDTO
    let text: String
    
    private enum CodingKeys: String, CodingKey {
        
        case text = "reviewText"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        reviews = try HomeCommonResponseDTO(from: decoder)
        text = try container.decode(String.self, forKey: .text)
        keywords = try RecommendKeywordResponseDTO(from: decoder)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: HomeBestReviewResponseDTO, rhs: HomeBestReviewResponseDTO) -> Bool {
        lhs.id == rhs.id
    }
}
