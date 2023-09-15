//
//  AnalyticManagerUser.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/09/15.
//

import Foundation

enum AnalyticManagerUser: AnalyticManagerEventProtocol {
    
    case authType
    case accountCreationDate
    case mainPurpose
    case breadType
    case ingredientsType
    case totalReview
    case totalFavorites
    case totalReviewReport
    
    var name: String {
        switch self {
        case .authType: return "auth type"
        case .accountCreationDate: return "account creation date"
        case .mainPurpose: return "main purpose"
        case .breadType: return "bread type"
        case .ingredientsType: return "ingredients type"
        case .totalReview: return "total review"
        case .totalFavorites: return "total favorites"
        case .totalReviewReport: return "total review report"
        }
    }    
}
