//
//  BestRepository.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 6/29/24.
//

import Foundation

import GBNetwork

final class BestRepositoryImpl: BestRepository {
    
    private let apiClient: APIClient<BestEndpoint> = .init()
    
    func getBestBakeries() async throws -> [BestBakery] {
        let rawResponse = try await apiClient.send(.getBestBakeries)
        let response = try rawResponse.decode(to: [BestBakeryResponseDTO].self)
        
        switch response.code {
        case 200..<300:
            return response.data.map { $0.toDomain() }
        case 401:
            if response.message == MemberError.invalidToken.rawValue {
                throw MemberError.invalidToken
            } else if response.message == MemberError.expiredToken.rawValue {
                throw MemberError.expiredToken
            }  else { throw MemberError.otherError }
        default:
            throw MemberError.otherError
        }
    }
    
    func getBestReviews() async throws -> [BestReview] {
        let rawResponse = try await apiClient.send(.getBestReviews)
        let response = try rawResponse.decode(to: [BestReviewResponseDTO].self)
        
        switch response.code {
        case 200..<300:
            return response.data.map { $0.toDomain() }
        case 401:
            if response.message == MemberError.invalidToken.rawValue {
                throw MemberError.invalidToken
            } else if response.message == MemberError.expiredToken.rawValue {
                throw MemberError.expiredToken
            } else { throw MemberError.otherError }
        default:
            throw MemberError.otherError
        }
    }
}

enum MemberError: String, Error {
    /// 유효하지 않은 토큰 ( 401 )
    case invalidToken = "엑세스 토큰이 없습니다"
    /// 만료된 토큰 ( 401 )
    case expiredToken = "만료된 토큰입니다"
    /// 그 외의 오류 ( 404, 500번대 )
    case otherError
}
