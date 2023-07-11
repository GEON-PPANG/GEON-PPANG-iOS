//
//  FilterIngredientDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/12.
//

import Foundation

enum FilterIngredientType: String, CaseIterable {
    case isNutrientOpen = "영양성분 공개"
    case isIngredientOpen = "원재료 공개"
    case isNotOpen = "비공개"
}

struct FilterIngredientDTO {
    let type: FilterIngredientType
    let isSeleted: Bool
}
