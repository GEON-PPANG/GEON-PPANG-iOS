//
//  FilterBreadTypeDTO.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/12.
//

import Foundation

enum FilterBreadType: String, CaseIterable {
    case isGlutenFree = "글루텐프리"
    case isVegan = "비건빵"
    case isNutFree = "넛프리"
    case isSugarless = "저당, 무설탕"
    
    var description: String {
        switch self {
        case .isGlutenFree: return "NO 글루텐 포함\n밀 , 곡물류"
        case .isVegan: return "NO 동물성재료\n(유제품, 계란)"
        case .isNutFree: return "NO 견과류"
        case .isSugarless: return "대체당 사용"
        }
    }
}

struct FilterBreadTypeDTO {
    let type: FilterBreadType
    let isSelected: Bool
}
