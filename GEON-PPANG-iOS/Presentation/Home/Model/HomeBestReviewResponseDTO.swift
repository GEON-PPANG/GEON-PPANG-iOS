//
//  HomeBestReviewResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//


// MARK: - HomeBestReviewResponseDTO

struct HomeBestReviewResponseDTO: Hashable {

    let bakeryID: Int
    let bakeryName: String
    let isHACCP: Bool
    let isVegan: Bool
    let isNONGMO: Bool
    let firstNearStation: String
    let secondNearStation: String? 
    let isBooked: Bool
    let bookmarkCount: Int
    let bakeryPicture: String
    let reviewCount: Int
    let reviewText: String
    let firstMaxRecommendKeyword: String
    let secondMaxRecommendKeyword: String?
}

extension HomeBestReviewResponseDTO {
   static let item: [HomeBestReviewResponseDTO] = [HomeBestReviewResponseDTO(bakeryID: 1, bakeryName: "건대 초코빵", isHACCP: true, isVegan: true, isNONGMO: false, firstNearStation: "건대역", secondNearStation: "건대", isBooked: true, bookmarkCount: 7, bakeryPicture: "빵집사진url", reviewCount: 6, reviewText: "정말 너무 맛있었어요! 갓 구운 빵이 예술이었던 것 같아요", firstMaxRecommendKeyword: "친절해요", secondMaxRecommendKeyword: "제로웨이스트")
    ]
}
