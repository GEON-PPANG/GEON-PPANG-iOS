//
//  FilterEnum.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/13.
//

import Foundation

enum FilterType {
    case purpose
    case breadType
    case ingredient
    
    var cellSize: CGSize {
        switch self {
        case .purpose, .ingredient:
            return .init(width: CGFloat().convertByWidthRatio(327),
                         height: CGFloat().convertByHeightRatio(106))
        case .breadType:
            return .init(width: CGFloat().convertByWidthRatio(153),
                         height: CGFloat().convertByHeightRatio(161))
        }
    }
    
    var labelSpacing: CGFloat {
        switch self {
        case .purpose: return 9
        case .breadType: return 24
        case .ingredient: return 0
        }
    }
}

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
    
    var data: String {
        switch self {
        case .health: return "HEALTH"
        case .taste: return "TASTE"
        case .vegan: return "VEGAN"
        }
    }
}

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

enum FilterIngredientType: String, CaseIterable {
    case isNutrientOpen = "영양성분 공개"
    case isIngredientOpen = "원재료 공개"
    case isNotOpen = "비공개"
}

