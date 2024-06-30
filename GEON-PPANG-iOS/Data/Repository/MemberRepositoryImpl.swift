//
//  MemberRepositoryImpl.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 6/30/24.
//

import Foundation

import GBNetwork

final class MemberRepositoryImpl: MemberRepository {
    
    private let apiClient: APIClient<MemberEndpoint> = .init()
    
    func postFilter(purpose: PurposeType, bread: [BakeryType], nutrient: [NutrientType]) async throws {
        let requestDTO = PostFilterRequestDTO(
            purpose: purpose.upperCased(),
            breadType: bread.map { $0.id },
            nutrientType: nutrient.map { $0.id }
        )
        
        let (data, response) = try await apiClient.send(.postFilter(body: requestDTO))
        
        
    }
}
