//
//  FilterPurposeModel.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/12.
//

import Foundation

enum FilterType: String, CaseIterable {
    case health = "건강 · 체질"
    case diet = ""
}

struct FilterPurposeModel {
    let type: FilterType
    var isSelected: Bool
}
