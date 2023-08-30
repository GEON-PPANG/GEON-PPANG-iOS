//
//  RecomendKeywordResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/08/21.
//

import Foundation

struct RecommendKeywordResponseDTO: Hashable, Codable {
    
    let first: String
    let second: String?
    
    private enum CodingKeys: String, CodingKey {
        
        case first = "firstMaxRecommendKeyword"
        case second = "secondMaxRecommendKeyword"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        first = try container.decode(String.self, forKey: .first)
        second = try container.decodeIfPresent(String.self, forKey: .second)
    }
    
    var keywords: [String] {
        if let secondKeyword = second {
            return [first, secondKeyword]
        } else {
            return [first]
        }
    }
    
}
