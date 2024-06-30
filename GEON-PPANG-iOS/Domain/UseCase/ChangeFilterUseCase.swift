//
//  FilterUseCase.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 6/30/24.
//

import Foundation

protocol FilterUseCase {
    func changeFilter(purpose: PurposeType, bakeries: [BakeryType], nutrient: [NutrientType])
}

final class FilterUseCaseImpl: FilterUseCase {
    func changeFilter(purpose: PurposeType, bakeries: [BakeryType], nutrient: [NutrientType]) {
        <#code#>
    }
}
