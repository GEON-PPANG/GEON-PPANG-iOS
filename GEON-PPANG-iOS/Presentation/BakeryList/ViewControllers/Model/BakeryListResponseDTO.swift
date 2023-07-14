//
//  BakeryListResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/11.
//

// MARK: - BakeryListResponseDTO
struct BakeryListResponseDTO: Hashable {
    let bakeryID: Int
    let bakeryName: String
    let bakeryPicture: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNonGMO: Bool
    let breadType: BreadResponseType
    let firstNearStation: String
    let secondNearStation: String?
    let isBooked: Bool
    let bookmarkCount: Int
}

// MARK: - BreadType

struct BreadResponseType: Codable, Hashable {
    let breadTypeID: Int
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

extension BakeryListResponseDTO {
    static let item: [BakeryListResponseDTO] = [BakeryListResponseDTO(bakeryID: 1, bakeryName: "건대 초코빵", bakeryPicture: "ursl", isHACCP: true, isVegan: true, isNonGMO: true, breadType: .breadItem1, firstNearStation: "건대역", secondNearStation: "건대", isBooked: true, bookmarkCount: 7),
                                                BakeryListResponseDTO(bakeryID: 2, bakeryName: "건대 초코빵", bakeryPicture: "ursl", isHACCP: true, isVegan: true, isNonGMO: true, breadType: .breadItem2, firstNearStation: "건대역", secondNearStation: "건대", isBooked: true, bookmarkCount: 7),
               BakeryListResponseDTO(bakeryID: 3, bakeryName: "건대 초코빵", bakeryPicture: "ursl", isHACCP: true, isVegan: true, isNonGMO: true, breadType: .breadItem3, firstNearStation: "건대역", secondNearStation: "건대", isBooked: true, bookmarkCount: 7)
    ]
}
extension BreadResponseType {
    static let breadItem1: BreadResponseType = BreadResponseType(breadTypeID: 1, breadTypeName: "글루텐프리", isGlutenFree: true, isVegan: true, isNutFree: true, isSugarFree: true)
    static let breadItem2: BreadResponseType = BreadResponseType(breadTypeID: 1, breadTypeName: "글루텐프리", isGlutenFree: true, isVegan: false, isNutFree: false, isSugarFree: true)
    static let breadItem3: BreadResponseType = BreadResponseType(breadTypeID: 1, breadTypeName: "글루텐프리", isGlutenFree: true, isVegan: true, isNutFree: true, isSugarFree: true)
    
}
