//
//  URLConstant.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/06.
//
import Foundation

struct URLConstant {
    // MARK: - Auth
    
    static let checkEmail = "/validation/email"
    static let login = "auth/login"
    
    // MARK: - Filter
    
    static let changeFilter = "/member/types"
    
    // MARK: - Home
    
    static let bestBakery = "/best/bakeries"
    static let bestReviews = "/best/reviews"
    
    // MARK: - Search
    
    static let search = "/search/bakeries"
    
    // MARK: - Bakery
    
    static let bakeryList = "/bakeries"
    static let writeReview = "/reviews"
    
    // MARK: - MyPage
    
    static let member = "/member"
    
    // MARK: - Bookmark
    
    static let bookmarks = "member/bookMarks"
    static let myReviews = "member/reviews"
    static let bookmark = "/bookMarks"
    
}
