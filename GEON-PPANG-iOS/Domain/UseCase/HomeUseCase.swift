//
//  HomeUseCase.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 6/29/24.
//

import Foundation
import Combine

protocol HomeUseCase {
    func fetchBestBakeries() async throws -> [BestBakery]
    func fetchBestReviews() async throws -> [BestReview]
}

final class HomeUseCaseImpl: HomeUseCase {
    let bestRepository: BestRepository
    
    init(bestRepository: BestRepository) {
        self.bestRepository = bestRepository
    }
    
    func fetchBestBakeries() async throws -> [BestBakery] {
        do {
            return try await bestRepository.getBestBakeries()
        }
        catch MemberError.expiredToken {
            throw MemberError.expiredToken
        }
        catch MemberError.invalidToken {
            throw MemberError.invalidToken
        }
    }
    
    func fetchBestReviews() async throws -> [BestReview] {
        do {
            return try await bestRepository.getBestReviews()
        }
        catch MemberError.expiredToken {
            throw MemberError.expiredToken
        }
        catch MemberError.invalidToken {
            throw MemberError.invalidToken
        }
    }
}
