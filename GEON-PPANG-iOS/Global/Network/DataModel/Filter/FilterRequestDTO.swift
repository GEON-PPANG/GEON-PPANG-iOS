//
//  FilterDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/13.
//

import Foundation

struct FilterRequestDTO: Codable {
    var mainPurpose: String
    var breadType: BreadRequestType
    var nutrientType: NutrientRequestType
    
    static var sharedData = FilterRequestDTO()
    
    private init() {
        self.mainPurpose = ""
        self.breadType = .init(isGlutenFree: false,
                               isVegan: false,
                               isNutFree: false,
                               isSugarFree: false)
        self.nutrientType = .init(isNutrientOpen: false,
                                  isIngredientOpen: false,
                                  isNotOpen: false)
    }
}
