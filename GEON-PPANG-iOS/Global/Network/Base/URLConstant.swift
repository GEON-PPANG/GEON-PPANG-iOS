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
    static let checkNickname = "/validation/nickname"
    static let login = "/auth/login"
    static let signup = "/auth/signup"
    static let refreshToken = "/auth/refresh"
    static let logout = "auth/logout"
    static let withdraw = "auth/withdraw"
    
    // MARK: - Filter
    
    static let changeFilter = "/member/types"
    
    // MARK: - Home
    
    static let bestBakery = "/best/bakeries"
    static let bestReviews = "/best/reviews"
    
    // MARK: - Search
    
    static let search = "/search/bakeries"
    
    // MARK: - Bakery
    
    static let bakeryList = "/bakeries"
    
    // MARK: - MyPage
    
    static let member = "/member"
    
    // MARK: - Review
    
    static let review = "/reviews"
    
    // MARK: - Bookmark
    
    static let bookmarks = "member/bookMarks"
    static let myReviews = "member/reviews"
    static let bookmark = "/bookMarks"
    
}
