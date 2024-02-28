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
    let breadTypeList: [BreadType]
    let mapURL, homepageURL, instagramURL: String
    let address, openingHours, closedDay, phoneNumber: String
    let menuList: [MenuList]
    let isBookMarked: Bool
    let bookMarkCount: Int
    
    enum CodingKeys: String, CodingKey {
        case bakeryID = "bakeryId"
        case bakeryName, bakeryPicture, isHACCP, isVegan, isNonGMO, firstNearStation, secondNearStation, reviewCount, breadTypeList
        case mapURL = "mapUrl"
        case homepageURL = "homepageUrl"
        case instagramURL = "instagramUrl"
        case address, openingHours, closedDay, phoneNumber, menuList, isBookMarked, bookMarkCount
    }
}

// MARK: - BreadType

struct BreadType: Codable {
    let breadTypeId: Int
    
    func toString() -> String {
        switch self.breadTypeId {
        case 1: return "글루텐프리"
        case 2: return "비건빵"
        case 3: return "넛프리"
        case 4: return "대체당"
        default: return ""
        }
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

// MARK: - Extentsion

extension BakeryDetailResponseDTO {
    
    static func initialDTO() -> BakeryDetailResponseDTO {
        
        return .init(bakeryID: 0,
                     bakeryName: "",
                     bakeryPicture: "",
                     isHACCP: false,
                     isVegan: false,
                     isNonGMO: false,
                     firstNearStation: "",
                     secondNearStation: "",
                     reviewCount: 0,
                     breadTypeList: [.init(breadTypeId: 0)],
                     mapURL: "",
                     homepageURL: "",
                     instagramURL: "",
                     address: "",
                     openingHours: "",
                     closedDay: "",
                     phoneNumber: "",
                     menuList: [MenuList(menuID: 0,
                                         menuName: "",
                                         menuPrice: 0)],
                     isBookMarked: false,
                     bookMarkCount: 0)
    }
}
