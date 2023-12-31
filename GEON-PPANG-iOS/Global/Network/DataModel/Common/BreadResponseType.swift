//
//  BreadResponseType.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/19.
//

import Foundation

struct BreadResponseType: Codable, Hashable, BakeryTypeProtocol {
    let breadTypeID: Int
    let name: String
    let isGlutenFree: Bool
    let isVegan: Bool
    let isNutFree: Bool
    let isSugarFree: Bool
    
    enum CodingKeys: String, CodingKey {
        case breadTypeID = "breadTypeId"
        case name = "breadTypeName"
        case isGlutenFree
        case isVegan
        case isNutFree
        case isSugarFree
    }
    
    func configureTrueOptions() -> [(String, Bool)] {
        
        var optionsBoolArray: [(String, Bool)] = []
        if isGlutenFree { optionsBoolArray.append((I18N.BakeryList.glutenfree, true)) }
        if isVegan { optionsBoolArray.append((I18N.BakeryList.vegan, true)) }
        if isNutFree { optionsBoolArray.append((I18N.BakeryList.nutfree, true)) }
        if isSugarFree { optionsBoolArray.append((I18N.BakeryList.subSugar, true)) }
        return optionsBoolArray
    }
    
    func configureTrueOptionStrings() -> [String] {
        return configureTrueOptions()
            .map { $0.0 }
    }
    
    static func emptyBreadType() -> BreadResponseType {
        
        return BreadResponseType(breadTypeID: 0,
                                 name: "",
                                 isGlutenFree: false,
                                 isVegan: false,
                                 isNutFree: false,
                                 isSugarFree: false)
    }
}
