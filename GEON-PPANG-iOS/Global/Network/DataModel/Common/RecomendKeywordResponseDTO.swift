//
//  RecomendKeywordResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/08/21.
//

import Foundation

struct RecomendKeywordResponseDTO: Hashable, Codable {
    
    let firstKeyword: String
    let secondKeyword: String?
    
    private enum CodingKeys: String, CodingKey {
        
        case firstKeyword = "firstMaxRecommendKeyword"
        case secondKeyword = "secondMaxRecommendKeyword "
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstKeyword = try container.decode(String.self, forKey: .firstKeyword)
        secondKeyword = try container.decodeIfPresent(String.self, forKey: .secondKeyword)
    }
    
}
