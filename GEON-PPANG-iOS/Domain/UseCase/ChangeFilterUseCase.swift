//
//  FilterUseCase.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 6/30/24.
//

import Foundation

protocol FilterUseCase {
    func changeFilter(purpose: PurposeType, breadTypes: [BakeryType], nutrientTypes: [NutrientType]) async throws
}

final class FilterUseCaseImpl: FilterUseCase {
    
    private let repository: MemberRepository
    
    init(repository: MemberRepository) {
        self.repository = repository
    }
    
    func changeFilter(purpose: PurposeType, breadTypes: [BakeryType], nutrientTypes: [NutrientType]) async throws {
        do {
            try await repository.postFilter(purpose: purpose, bread: breadTypes, nutrient: nutrientTypes)
        }
        catch MemberError.expiredToken {
            // TODO: token revalidation logic
        }
        catch MemberError.invalidToken {
            // TODO: redirect to onboarding
        }
    }
}
