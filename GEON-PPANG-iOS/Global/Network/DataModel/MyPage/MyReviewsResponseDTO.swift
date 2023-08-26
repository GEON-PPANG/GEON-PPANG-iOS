//
//  MyReviewsResponseDTO.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/19.
//

import Foundation

// MARK: - MyReviewsResponseDTO

struct MyReviewsResponseDTO: Decodable {
    
    var id = UUID()
    let bakeryList: BakeryCommonListResponseDTO
    let createdAt: String

    func hash(into hasher: inout Hasher) {
        
        hasher.combine(id)
    }

    static func == (lhs: MyReviewsResponseDTO, rhs: MyReviewsResponseDTO) -> Bool {
        lhs.id == rhs.id
    }
 
}
