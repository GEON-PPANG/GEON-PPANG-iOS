//
//  RecomendKeywordResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/08/21.
//

import Foundation

struct RecomendKeywordResponseDTO: Hashable, Codable {
    
    let firstMaxRecommendKeyword: String
    let secondMaxRecommendKeyword: String?

}
