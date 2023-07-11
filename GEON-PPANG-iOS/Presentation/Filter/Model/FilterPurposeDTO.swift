//
//  FilterPurposeModel.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/12.
//

import Foundation

enum FilterPurposeType: String, CaseIterable {
    case health = "건강 · 체질"
    case taste = "맛 · 다이어트"
    case vegan = "비건 · 채식지향"
    
    var description: String {
        switch self {
        case .health: return "아토피 , 알레르기 , 암 , 당뇨 , 소화문제"
        case .taste: return "그냥 맛있어서! 식이 관리를 위해"
        case .vegan: return "종교 , 환경 , 동물 , 노동권을 위한 비거니즘"
        }
    }
}

struct FilterPurposeDTO {
    let type: FilterPurposeType
}
