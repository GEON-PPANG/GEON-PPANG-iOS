//
//  BakeryDetailResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/20.
//

import Foundation

// MARK: - BakeryDetailResponseDTO

struct BakeryDetailResponseDTO: Codable {
    let bakeryID: Int
    let bakeryName: String
    let bakeryPicture: String
    let isHACCP, isVegan, isNonGMO: Bool
    let firstNearStation, secondNearStation: String
    let isBookMarked: Bool
    let bookMarkCount, reviewCount: Int
    let breadType: BreadResponseType
    let homepage: String
    let address, openingTime, closedDay, phoneNumber: String
    let menuList: [MenuList]
    
    enum CodingKeys: String, CodingKey {
        case bakeryID = "bakeryId"
        case bakeryName, bakeryPicture, isHACCP, isVegan, isNonGMO, firstNearStation, secondNearStation, isBookMarked, bookMarkCount, reviewCount, breadType, homepage, address, openingTime, closedDay, phoneNumber, menuList
    }
}

// MARK: - BreadType

struct BreadType: Codable {
    let breadTypeID: Int
    let breadTypeName: String
    let isGlutenFree, isVegan, isNutFree, isSugarFree: Bool
    
    enum CodingKeys: String, CodingKey {
        case breadTypeID = "breadTypeId"
        case breadTypeName, isGlutenFree, isVegan, isNutFree, isSugarFree
    }
}

// MARK: - MenuList

struct MenuList: Codable {
    let menuID: Int
    let menuName: String
    let menuPrice: Int
    
    enum CodingKeys: String, CodingKey {
        case menuID = "menuId"
        case menuName, menuPrice
    }
}
