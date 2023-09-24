//
//  BakeryListEmptyTpe.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/09/04.
//

import UIKit

enum EmptyType: String {
    case noReview = "작성된 리뷰가 없어요!"
    case noMyReview = "내가 쓴 리뷰가 없어요!"
    case noBookmark = "저장 목록이 없어요!"
    case noSearch = "검색결과가 없어요\n다른 키워드로 검색해보세요!"
    case initialize = "궁금하신 건빵집을\n검색해보세요!"
    
    var icon: UIImage {
        switch self {
        case .noReview, .noMyReview: return .noReviewImage
        case .noBookmark: return .noBookmarkImage
        case .noSearch: return .noSearchResultImage
        case .initialize: return .searchImage
        }
    }
    
    var subTitle: String {
        switch self {
        case .noSearch: return "다른 키워드로 검색해보세요!"
        default: return ""
        }
    }
}
