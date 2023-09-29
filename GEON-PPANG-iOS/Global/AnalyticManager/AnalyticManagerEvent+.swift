//
//  AnalyticManagerEvent+.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/09/14.
//

import Foundation

extension AnalyticManagerEvent {
        
    /// General
    
    enum General: AnalyticManagerEventProtocol {
                
        case openApp
        case closeApp
        case loginApp(loginType: String)
        case logoutApp
        case withdrawApp
        
        var name: String {
            switch self {
            case .openApp: return "open_app"
            case .closeApp: return "close_app"
            case .loginApp: return "login_app"
            case .logoutApp: return "logout_app"
            case .withdrawApp: return "withdraw_app"
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
        case completeFilterOnboarding(mainPurpose: String, breadType: [String], ingredientsType: [String])
        
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
            case .completeFilterOnboarding(mainPurpose: let mainPurpose, breadType: let breadType, ingredientsType: let ingredientsType):
                return ["main purpose": mainPurpose, "breadtype": breadType, "ingredients type": ingredientsType]
            default: return nil
            }
        }
    }
    
    /// Home
    
    enum Home: AnalyticManagerEventProtocol {
        
        case clickRecommendStore(bakery: String)
        case clickRecommendReview(bakery: String)
        case clickSearchHome
        case completeSearchHome(keyword: String)
        case startFilterHome
        case clickFilterBackHome
        case completeFilterHome(mainPurpose: String, breadType: [String], ingredientsType: [String])
        
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
            case .clickRecommendStore(bakery: let bakery): return ["bakery": bakery]
            case .clickRecommendReview(bakery: let bakery): return ["bakery": bakery]
            
            case .completeSearchHome(keyword: let keyword): return ["keyword": keyword]
            case .completeFilterHome(mainPurpose: let mainPurpose, breadType: let breadType, ingredientsType: let ingredientsType):
                return ["main purpose": mainPurpose, "breadtype": breadType, "ingredients type": ingredientsType]
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
        case completeFilterList(mainPurpose: String, breadType: [String], ingredientsType: [String])
        
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
            case .completeFilterList(mainPurpose: let mainPurpose, breadType: let breadType, ingredientsType: let ingredientsType):
                return ["main purpose": mainPurpose, "breadtype": breadType, "ingredients type": ingredientsType]
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
        case clickReviewWritingOption(option: String)
        case clickRecommendKeyword(keyword: [String])
        case clickReviewWritingText
        case clickReviewWritingBack
        case clickReviewWritingStop
        case clickReviewWritingContinue
        case clickReviewWritingComplete
        case completeReviewWriting(option: String,
                                   keyword: [String],
                                   text: String)
        
        var name: String {
            switch self {
            case .startReviewWriting: return "start_reviewwriting"
            case .clickReviewWritingOption: return "click_reviewwriting_option"
            case .clickRecommendKeyword: return "click_recommend_keyword"
            case .clickReviewWritingText: return "click_reviewwriting_text"
            case .clickReviewWritingBack: return "click_reviewwriting_back"
            case .clickReviewWritingStop: return "click_reviewwriting_stop"
            case .clickReviewWritingContinue: return "click_reviewwriting_continue"
            case .clickReviewWritingComplete: return "click_reviewwriting_complete"
            case .completeReviewWriting: return "complete_reviewwriting"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .clickReviewWritingOption(option: let option): return ["option": option]
            case .clickRecommendKeyword(keyword: let keyword): return ["keyword": keyword]
            case .completeReviewWriting(option: let option, keyword: let keyword, text: let text): return ["option": option,
                                                                                                           "keyword": keyword,
                                                                                                           "text": text]
            default: return nil
            }
        }
    }
    
    /// MyPage
    
    enum MyPage: AnalyticManagerEventProtocol {
        
        case clickMystore
        case clickMyreview
        case startFilterMypage
        case clickFilterBackMypage
        case completeFilterMypage(mainPurpose: String, breadType: [String], ingredientsType: [String])
        
        var name: String {
            switch self {
            case .clickMystore: return "click_mystore"
            case .clickMyreview: return "click_myreview"
            case .startFilterMypage: return "start_filter_mypage"
            case .clickFilterBackMypage: return "click_filter_back_mypage"
            case .completeFilterMypage: return "complete_filter_mypage"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .completeFilterMypage(mainPurpose: let mainPurpose, breadType: let breadType, ingredientsType: let ingredientsType):
                return ["main purpose": mainPurpose, "breadtype": breadType, "ingredients type": ingredientsType]
            default: return nil
            }
        }
    }
    
    /// ReportReview
    
    enum ReportReview: AnalyticManagerEventProtocol {
        case startReviewReport
        case clickReviewReportOption(option: String)
        case clickReviewReportBack
        case clickReviewReportComplete
        case completeReviewReport(option: String, text: String)
        
        var name: String {
            switch self {
            case .startReviewReport: return "start_reviewreport"
            case .clickReviewReportOption: return "click_reviewreport_option"
            case .clickReviewReportBack: return "click_reviewreport_back"
            case .clickReviewReportComplete: return "click_reviewreport_complete"
            case .completeReviewReport: return "complete_reviewreport"
            }
        }
        
        var parameters: [String: Any]? {
            switch self {
            case .clickReviewReportOption(option: let option): return ["option": option]
            case .completeReviewReport(option: let option, text: let text): return ["option": option, "text": text]
            default: return nil
            }
        }
    }
}
