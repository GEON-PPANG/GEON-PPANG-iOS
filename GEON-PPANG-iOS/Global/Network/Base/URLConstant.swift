//
//  URLConstant.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/06.
//
import Foundation

struct URLConstant {
    
    // MARK: - validation
    
    struct Validation {
        static let email = "/email"
        static let nickname = "/nickname"
    }
    
    // MARK: - auth
    
    struct Auth {
        static let login = "/login"
        static let signup = "/signup"
        static let refresh = "/refresh"
        static let logout = "/logout"
        static let withdraw = "/withdraw"
    }
    
    // MARK: - Member
    
    struct Member {
        static let types = "/types"
        static let bookmarks = "/bookMarks"
        static let reviews = "/reviews"
        static let nickname = "/nickname"
    }
    
    // MARK: - Best
    
    struct Best {
        static let bakeries = "/bakeries"
        static let reviews = "/reviews"
    }
    
    // MARK: - Search
    
    struct Search {
        static let bakeries = "/bakeries"
    }
    
    // MARK: - Report
    
    struct Report {
        static let review = "/review"
    }
}
