//
//  FilterEnum.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/13.
//

import UIKit

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
        case .breadType: return 20
        case .ingredient: return 9
        }
    }
    
    var lineSpacing: CGFloat {
        return 20
    }
    
    var descriptionFont: UIFont? {
        switch self {
        case .purpose: return .bodyM1
        case .breadType: return .subHead
        case .ingredient: return nil
        }
    }
    
    var isMultipleSelectionEnabled: Bool {
        switch self {
        case .purpose: return false
        case .breadType, .ingredient: return true
        }
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
