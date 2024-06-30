//
//  BakeryType.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 6/21/24.
//

import Foundation

enum BakeryType {
    case 글루텐프리
    case 비건빵
    case 넛프리
    case 대체당
}

extension BakeryType {
    var id: Int {
        switch self {
        case .글루텐프리: 1
        case .비건빵: 2
        case .넛프리: 3
        case .대체당: 4
        }
    }
}
