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
        
        let rawResponse = try await apiClient.send(.postFilter(request: requestDTO))
        let response = try rawResponse.decode(to: PostFilterResponseDTO.self)
        
        switch response.code {
        case 200..<300:
            return
        case 400:
            throw GBDataError.missingValue
        case 401:
            if response.message == GBDataError.invalidToken.rawValue {
                throw GBDataError.invalidToken
            } else if response.message == GBDataError.expiredToken.rawValue {
                throw GBDataError.expiredToken
            }
        case 404:
            throw GBDataError.invalidRequest
        default: 
            throw GBDataError.unknownError
        }
    }
}
