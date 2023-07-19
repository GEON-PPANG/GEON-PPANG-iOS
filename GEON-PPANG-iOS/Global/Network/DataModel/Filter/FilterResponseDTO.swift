//
//  FilterResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/17.
//

import Foundation

struct FilterResponseDTO: Codable {
    let memberID: Int
    let mainPurpose: String
    let breadType: BreadResponseType
    let nutrientType: NutrientResponseType
    
    enum CodingKeys: String, CodingKey {
        case memberID = "memberId"
        case mainPurpose
        case breadType
        case nutrientType
    }
}

struct NutrientResponseType: Codable {
    let nutrientTypeID: Int
    let nutrientTypeName: String
    let isNutrientOpen: Bool
    let isIngredientOpen: Bool
    let isNotOpen: Bool
    
    enum CodingKeys: String, CodingKey {
        case nutrientTypeID = "nutrientTypeId"
        case nutrientTypeName
        case isNutrientOpen
        case isIngredientOpen
        case isNotOpen
    }
}
