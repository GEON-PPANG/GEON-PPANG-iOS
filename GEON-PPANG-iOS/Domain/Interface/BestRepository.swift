//
//  BestRepository.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 7/9/24.
//

import Foundation

protocol BestRepository {
    func getBestBakeries() async throws -> [BestBakery]
    func getBestReviews() async throws -> [BestReview]
}

