//
//  BakeryListResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/11.
//

// MARK: - BakeryListResponseDTO
struct BakeryListResponseDTO: Hashable {
    let bakeryID: Int
    let bakeryName, bakeryPicture: String
    let isHACCP, isVegan, isNonGMO: Bool
    let breadType: BreadType
    let firstNearStation, secondNearStation: String
    let isBooked: Bool
    let bookmarkCount: Int
}

// MARK: - BreadType

struct BreadType: Hashable {
    let breadTypeID: Int
    let breadTypeName: String
    let isGlutenFree, isVegan, isNutFree, isSugarFree: Bool
}

extension BakeryListResponseDTO {
    static let item: [BakeryListResponseDTO] = [BakeryListResponseDTO(bakeryID: 1, bakeryName: "건대 초코빵", bakeryPicture: "ursl", isHACCP: true, isVegan: true, isNonGMO: false, breadType: breadItem, firstNearStation: "건대역", secondNearStation: "건대", isBooked: true, bookmarkCount: 7)]
    static let breadItem: BreadType = BreadType(breadTypeID: 1, breadTypeName: "글루텐프리", isGlutenFree: true, isVegan: false, isNutFree: false, isSugarFree: false)
}
