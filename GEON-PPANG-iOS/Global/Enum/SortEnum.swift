//
//  SortEnum.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/15.
//

import Foundation

enum SortBakery: CaseIterable {
    case byDefault
    case byReviews
    
    var description: String {
        switch self {
        case .byDefault: return I18N.SortBottomSheet.byDefault
        case .byReviews: return I18N.SortBottomSheet.byReviews
        }
    }
    var sortValue: String {
        switch self {
        case .byDefault: return "default"
        case .byReviews: return "review"
        }
    }
}
