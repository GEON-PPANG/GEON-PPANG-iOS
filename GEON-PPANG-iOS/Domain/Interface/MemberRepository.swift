//
//  MemberRepository.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 6/30/24.
//

import Foundation

protocol MemberRepository {
    func postFilter(purpose: PurposeType, bakery: [BakeryType], nutrient: [NutrientType])
}
