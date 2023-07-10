//
//  HomeBestBakeryResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

// MARK: - HomeBestBakeryResponseDTO

struct HomeBestBakeryResponseDTO: Hashable {
    let bakeryID: Int
    let bakeryName: String
    let isHACCP, isVegan: Bool
    let isNONGMO: Bool?
    let firstNearStation, secondNearStation: String
    let isBooked: Bool
    let bookmarkCount: Int
    let bakeryPicture: String
    let reviewCount: Int
}

extension HomeBestBakeryResponseDTO {
    static let item: [HomeBestBakeryResponseDTO] = [HomeBestBakeryResponseDTO(bakeryID: 1, bakeryName: "건대 초코빵", isHACCP: true, isVegan: true, isNONGMO: false, firstNearStation: "건대역", secondNearStation: "건대", isBooked: false, bookmarkCount: 0, bakeryPicture: "빵집사진url", reviewCount: 6),
                                                    HomeBestBakeryResponseDTO(bakeryID: 2, bakeryName: "건대 초코빵", isHACCP: true, isVegan: true, isNONGMO: false, firstNearStation: "건대역", secondNearStation: "건대", isBooked: true, bookmarkCount: 7, bakeryPicture: "빵집사진url", reviewCount: 6),
                                                    HomeBestBakeryResponseDTO(bakeryID: 3, bakeryName: "건대 초코빵", isHACCP: true, isVegan: true, isNONGMO: false, firstNearStation: "건대역", secondNearStation: "건대", isBooked: true, bookmarkCount: 7, bakeryPicture: "빵집사진url", reviewCount: 6),
                                                    HomeBestBakeryResponseDTO(bakeryID: 4, bakeryName: "건대 초코빵", isHACCP: true, isVegan: true, isNONGMO: false, firstNearStation: "건대역", secondNearStation: "건대", isBooked: true, bookmarkCount: 7, bakeryPicture: "빵집사진url", reviewCount: 6)
    ]
}
