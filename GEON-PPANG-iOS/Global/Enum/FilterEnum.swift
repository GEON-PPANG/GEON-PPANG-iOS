//
//  FilterEnum.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/13.
//

import Foundation

enum FilterType: Int, CaseIterable {
    case purpose
    case breadType
    case ingredient
    
    // FilterCollectionViewHeader
    
    var title: String {
        switch self {
        case .purpose: return I18N.Filter.purposeTitle
        case .breadType: return I18N.Filter.breadTypeTitle
        case .ingredient: return I18N.Filter.ingredientTitle
        }
    }
    
    var subtitle: String {
        return I18N.Filter.subtitle
    }
    
    var hideSubtitle: Bool {
        switch self {
        case .purpose: return true
        case .breadType, .ingredient: return false
        }
    }
    
    // FilterCollectionViewCell
    
    var cells: [FilterCellModel] {
        switch self {
        case .purpose: return FilterCellModel.purpose
        case .breadType: return FilterCellModel.breadType
        case .ingredient: return FilterCellModel.ingredient
        }
    }
    
    var headerSize: CGSize {
        return CGSize(width: CGFloat().convertByWidthRatio(327),
                      height: 64)
    }
    
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
    
    var lineSpacing: CGFloat {
        return 20
    }
    
    var hideDescription: Bool {
        switch self {
        case .purpose, .breadType: return false
        case .ingredient: return true
        }
    }
    
    var isMultipleSelectionEnabled: Bool {
        switch self {
        case .purpose: return false
        case .breadType, .ingredient: return true
        }
    }
    
}

extension FilterType {
    
    static func everyCases() -> [FilterType] {
        
        return self.allCases.map { $0 }
    }
    
}

enum FilterPurposeType: String, CaseIterable {
    case health = "건강 · 체질"
    case diet = "맛 · 다이어트"
    case vegan = "비건 · 채식지향"

    var description: String {
        switch self {
        case .health: return "아토피 , 알레르기 , 암 , 당뇨 , 소화문제"
        case .diet: return "그냥 맛있어서! 식이 관리를 위해"
        case .vegan: return "종교 , 환경 , 동물 , 노동권을 위한 비거니즘"
        }
    }

    var data: String {
        switch self {
        case .health: return "HEALTH"
        case .diet: return "DIET"
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
