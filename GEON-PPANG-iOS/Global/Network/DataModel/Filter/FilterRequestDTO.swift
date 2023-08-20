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
    
    init(mainPurpose: String = "",
         breadType: BreadRequestType = .init(),
         nutrientType: NutrientRequestType = .init()) {
        self.mainPurpose = mainPurpose
        self.breadType = breadType
        self.nutrientType = nutrientType
    }
}

extension FilterRequestDTO {
    
    mutating func setPurpose(from values: [Bool]) {
        guard let index = values.firstIndex(of: true)
        else { return }
        switch index {
        case 0: mainPurpose = "HEALTH"
        case 1: mainPurpose = "DIET"
        case 2: mainPurpose = "VEGAN"
        default: return
        }
    }
    
    mutating func setBreadType(from values: [Bool]) {
        breadType.isGlutenFree = values[0]
        breadType.isVegan = values[1]
        breadType.isNutFree = values[2]
        breadType.isSugarFree = values[3]
    }
    
    mutating func setNutrientType(from values: [Bool]) {
        nutrientType.isNutrientOpen = values[0]
        nutrientType.isIngredientOpen = values[1]
        nutrientType.isNotOpen = values[2]
    }
}
