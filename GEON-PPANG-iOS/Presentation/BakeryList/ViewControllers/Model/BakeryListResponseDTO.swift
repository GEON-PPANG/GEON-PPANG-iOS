//
//  BakeryListResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/11.
//

import Foundation

// MARK: - BakeryListResponseDTO

struct BakeryListResponseDTO: Codable, Hashable, BakeryListProtocol {
    
    let bakeryID: Int
    let bakeryName: String
    let bakeryPicture: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let breadType: BreadResponseType
    let firstNearStation: String
    let secondNearStation: String?
    let isBookMarked: Bool
    let bookMarkCount: Int
    let reviewCount: Int
    
    enum CodingKeys: String, CodingKey {
        case bakeryID = "bakeryId"
        case bakeryName
        case bakeryPicture
        case isHACCP
        case isVegan
        case isNonGMO
        case breadType
        case firstNearStation
        case secondNearStation
        case isBookMarked
        case bookMarkCount
        case reviewCount
    }
    
    func convertToBakeryList() -> BakeryList {
        return BakeryList(bakeryID: bakeryID, bakeryName: bakeryName, bakeryPicture: bakeryPicture, isHACCP: isHACCP, isVegan: isVegan, isNonGMO: isNonGMO, breadType: breadType, firstNearStation: firstNearStation, secondNearStation: secondNearStation, isBookMarked: isBookMarked, bookMarkCount: bookMarkCount, reviewCount: reviewCount)
    }
}

// MARK: - BreadType

struct BreadResponseType: Codable, Hashable {
    let breadTypeId: Int
    let breadTypeName: String
    let isGlutenFree: Bool
    let isVegan: Bool
    let isNutFree: Bool
    let isSugarFree: Bool
    
    func configureTrueOptions() -> [(String, Bool)] {
        var optionsBoolArray: [(String, Bool)] = []
        if isGlutenFree { optionsBoolArray.append((I18N.BakeryList.glutenfree, true)) }
        if isVegan { optionsBoolArray.append((I18N.BakeryList.vegan, true)) }
        if isNutFree { optionsBoolArray.append((I18N.BakeryList.nutfree, true)) }
        if isSugarFree { optionsBoolArray.append((I18N.BakeryList.noSugar, true)) }
        return optionsBoolArray
    }
}

// BakeryList

struct BakeryList: Codable, Hashable, BakeryListProtocol {
    var id = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: BakeryList, rhs: BakeryList) -> Bool {
        lhs.id == rhs.id
    }
    
    let bakeryID: Int
    let bakeryName: String
    let bakeryPicture: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let breadType: BreadResponseType
    let firstNearStation: String
    let secondNearStation: String?
    let isBookMarked: Bool
    let bookMarkCount: Int
    let reviewCount: Int
    
}
