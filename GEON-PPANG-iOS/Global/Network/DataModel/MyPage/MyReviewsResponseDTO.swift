//
//  MyReviewsResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/19.
//

import Foundation

// MARK: - MyReviewsResponseDTO

struct MyReviewsResponseDTO: Decodable, Hashable {
    
    let bakeryList: BakeryCommonListResponseDTO
    let createdAt: String
    let reviewID: Int
    
    enum CodingKeys: String, CodingKey {
        case createdAt
        case reviewID = "reviewId"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.reviewID = try container.decode(Int.self, forKey: .reviewID)
        self.bakeryList = try BakeryCommonListResponseDTO(from: decoder)

    }
}
