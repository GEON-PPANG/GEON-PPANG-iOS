//
//  FilterDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/13.
//

import Foundation

struct FilterRequestDTO {
    let mainPurpose: String
    let breadType: BreadType
    let nutrientType: NutrientType
}

struct BreadType {
    var isGlutenFree: Bool
    var isVegan: Bool
    var isNutFree: Bool
    var isSugarFree: Bool
}

struct NutrientType {
    var isNutrientOpen: Bool
    var isIngredientOpen: Bool
    var isNotOpen: Bool
}
