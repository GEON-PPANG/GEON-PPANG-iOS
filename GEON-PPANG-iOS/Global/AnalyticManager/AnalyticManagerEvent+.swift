//
//  AnalyticManagerEvent+.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/09/14.
//

import Foundation

enum LoginType: String, CaseIterable {
    
    case EMAIL
    case KAKAO
    case APPLE
}

enum ViewDetail: String, CaseIterable {
    
    case HOME
    case LIST
}

extension AnalyticManagerEvent {
    
    /// General
    
    enum General: AnalyticManagerEventProtocol {
        
        
        case openApp
        case closeApp
        case loginApp(loginType: String)
        case logoutApp
        // linkout
        
        var name: String {
            switch self {
            case .openApp: return "open_app"
            case .closeApp: return "close_app"
            case .loginApp: return "login_app"
            case .logoutApp: return "logout_app"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .loginApp(loginType: let loginType): return ["login type": loginType]
            default: return nil
            }
        }
    }
    
    /// Onboarding
    
    enum Onboarding: AnalyticManagerEventProtocol {
        
        case startSignup(signUpType: String)
        case completeNickname(nickname: String)
        case completeSignup
        case clickSkip
        case startFilterOnboarding
        case clickMainpurpose(mainPurpose: String)
        case clickBreadtype(breadType: [String])
        case clickIngredientstype(ingredientsType: [String])
        case completeFilterOnboarding
        
        var name: String {
            switch self {
            case .startSignup: return "start_signup"
            case .completeNickname: return "complete_nickname"
            case .completeSignup: return "complete_signup"
            case .clickSkip: return "click_skip"
            case .startFilterOnboarding: return "start_filter_onboarding"
            case .clickMainpurpose: return "click_mainpurpose"
            case .clickBreadtype: return "click_breadtype"
            case .clickIngredientstype: return "click_ingredientstype"
            case .completeFilterOnboarding: return "complete_filter_onboarding"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .startSignup(signUpType: let signUpType): return ["signup type": signUpType]
            case .completeNickname(nickname: let nickname): return ["nickname": nickname]
            case .clickMainpurpose(mainPurpose: let mainPurpose): return ["main purpose": mainPurpose]
            case .clickBreadtype(breadType: let breadType): return ["breadtype": breadType]
            case .clickIngredientstype(ingredientsType: let ingredientsType): return ["ingredients type": ingredientsType]
            default: return nil
            }
        }
    }
    
    /// Home
    
    enum Home: AnalyticManagerEventProtocol {
        
        case clickRecommendStore
        case clickRecommendReview
        case clickSearchHome
        case completeSearchHome(keyword: String)
        case startFilterHome
        case clickFilterBackHome
        case completeFilterHome
        
        var name: String {
            switch self {
            case .clickRecommendStore: return "click_recommend_store"
            case .clickRecommendReview: return "click_recommend_review"
            case .clickSearchHome: return "click_search_home"
            case .completeSearchHome: return "complete_search_home"
            case .startFilterHome: return "start_filter_home"
            case .clickFilterBackHome: return "click_filter_back_home"
            case .completeFilterHome: return "complete_filter_home"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .completeSearchHome(keyword: let keyword): return ["keyword": keyword]
            default: return nil
            }
        }
    }
    
    /// List
    
    enum List: AnalyticManagerEventProtocol {
        
        case clickCategory(category: [String])
        case clickFilterOff
        case clickReviewArray
        case startFilterList
        case clickSearchList
        case completeSearchList(keyword: String)
        case clickFilterbackList
        case completeFilterList
        
        var name: String {
            switch self {
            case .clickCategory: return "click_category"
            case .clickFilterOff: return "click_filteroff"
            case .clickReviewArray: return "click_reviewarray"
            case .startFilterList: return "start_filter_list"
            case .clickSearchList: return "click_search_list"
            case .completeSearchList: return "complete_search_list"
            case .clickFilterbackList: return "click_filterback_list"
            case .completeFilterList: return "complete_filter_list"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .clickCategory(category: let category): return ["category": category]
            case .completeSearchList(keyword: let keyword): return ["keyword": keyword]
            default: return nil
            }
        }
    }
    
    /// Detail
    
    enum Detail: AnalyticManagerEventProtocol {
        
        case viewDetailpageAt(source: String)
        case clickNavigation
        case clickWebsite
        case clickInstagram
        case clickMystore
        case clickReviewReport
        
        var name: String {
            switch self {
            case .viewDetailpageAt: return "view_detailpage_at"
            case .clickNavigation: return "click_navigation"
            case .clickWebsite: return "click_website"
            case .clickInstagram: return "click_instagram"
            case .clickMystore: return "click_mystore"
            case .clickReviewReport: return "click_reviewreport"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .viewDetailpageAt(source: let source): return ["source": source]
            default: return nil
            }
        }
    }
    
    /// WriteReview
    
    enum WriteReview: AnalyticManagerEventProtocol {
        
        case startReviewWriting
        case completeReviewWriting(keyword: [String])
        
        var name: String {
            switch self {
            case .startReviewWriting: return "start_reviewwriting"
            case .completeReviewWriting: return "complete_reviewwriting"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .completeReviewWriting(keyword: let keyword): return ["keyword": keyword]
            default: return nil
            }
        }
    }
    
    /// MyPage
    
    enum MyPage: String {
        
        case click_mystore
        case click_myreview
        case start_filter_mypage
        case click_filter_back_mypage
        case complete_filte_mypage
    }
}
