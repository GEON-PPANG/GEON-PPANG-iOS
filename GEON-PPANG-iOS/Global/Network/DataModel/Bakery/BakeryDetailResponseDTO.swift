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
    let reviewCount: Int
    let breadType: BreadResponseType
    let mapURL, homepageURL, instagramURL: String
    let address, openingHours, closedDay, phoneNumber: String
    let menuList: [MenuList]
    let isBookMarked: Bool
    let bookMarkCount: Int
    
    enum CodingKeys: String, CodingKey {
        case bakeryID = "bakeryId"
        case bakeryName, bakeryPicture, isHACCP, isVegan, isNonGMO, firstNearStation, secondNearStation, reviewCount, breadType
        case mapURL = "mapUrl"
        case homepageURL = "homepageUrl"
        case instagramURL = "instagramUrl"
        case address, openingHours, closedDay, phoneNumber, menuList, isBookMarked, bookMarkCount
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
