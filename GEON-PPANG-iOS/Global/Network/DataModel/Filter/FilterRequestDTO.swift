//
//  FilterDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/13.
//

import Foundation

struct FilterRequestDTO: Codable {
    var mainPurpose: String
    var breadTypeList: [Int]
    var nutrientTypeList: [Int]
    
    init(mainPurpose: String = "",
         breadType: [Int] = [],
         nutrientType: [Int] = []) {
        self.mainPurpose = mainPurpose
        self.breadTypeList = breadType
        self.nutrientTypeList = nutrientType
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
        var selection: [Int] = []
        values.enumerated()
            .forEach { index, selected in
                if selected { selection.append(index + 1) }
            }
        breadTypeList = selection
    }
    
    mutating func setNutrientType(from values: [Bool]) {
        var selection: [Int] = []
        values.enumerated()
            .forEach { index, selected in
                if selected { selection.append(index + 1) }
            }
        nutrientTypeList = selection
    }
    
    func toBreadTypeStringArray() -> [String] {
        var value = [String]()
        for breadType in breadTypeList {
            switch breadType {
            case 1: value.append("GLUTENFREE")
            case 2: value.append("VEGAN")
            case 3: value.append("NUTFREE")
            case 4: value.append("SUGARFREE")
            default: break
            }
        }
        return value
    }
    
    func toNutrientTypeStringArray() -> [String] {
        var value = [String]()
        for nutrientType in nutrientTypeList {
            switch nutrientType {
            case 1: value.append("INGREDIENTS")
            case 2: value.append("MATERIAL")
            case 3: value.append("PRIVATE")
            default: break
            }
        }
        return value
    }
}
