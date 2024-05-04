//
//  UIImage+.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/03.
//

import UIKit

public extension UIImage {
    
    // 따로 픽셀이 적혀있지 않은 컴포넌트는 24px임.
    
    // MARK: - Icon
    
    enum Icon {
        
        // MARK: - Bread Types
        
        enum Cake {
            static let disabled = UIImage(named: "ic_cake_disable_20px")!.withRenderingMode(.alwaysOriginal)
            static let enabled = UIImage(named: "ic_cake_enable_20px")!.withRenderingMode(.alwaysOriginal)
        }
        
        enum Hard {
            static let disabled = UIImage(named: "ic_hard_disable_20px")!.withRenderingMode(.alwaysOriginal)
            static let enabled = UIImage(named: "ic_hard_enable_20px")!.withRenderingMode(.alwaysOriginal)
        }
        
        enum Sandwich {
            static let disabled = UIImage(named: "ic_sandwich_disable_20px")!.withRenderingMode(.alwaysOriginal)
            static let enabled = UIImage(named: "ic_sandwich_enable_20px")!.withRenderingMode(.alwaysOriginal)
        }
        
        // MARK: - Emoji
        
        enum Smile {
            static let px64 = UIImage(named: "ic_smile")!.withRenderingMode(.alwaysOriginal)
            static let px86 = UIImage(named: "ic_smile_86px")!.withRenderingMode(.alwaysOriginal)
        }
        static let sad = UIImage(named: "icon_sad")!.withRenderingMode(.alwaysOriginal)
        static let crying = UIImage(named: "icon_crying")!.withRenderingMode(.alwaysOriginal)
        
        // MARK: - arrow
        
        enum Arrow {
            static let down = UIImage(named: "ic_arrow_down")!.withRenderingMode(.alwaysOriginal)
            static let left = UIImage(named: "ic_arrow_left")!.withRenderingMode(.alwaysOriginal)
            static let right = UIImage(named: "ic_arrow_right")!.withRenderingMode(.alwaysOriginal)
            static let up = UIImage(named: "ic_arrow_up")!.withRenderingMode(.alwaysOriginal)
        }
        
        // MARK: - Logo
        
        enum Logo {
            static let px16 = UIImage(named: "ic_logo_16px")!.withRenderingMode(.alwaysOriginal)
            static let px20 = UIImage(named: "ic_logo_20px")!.withRenderingMode(.alwaysOriginal)
        }
        
        // MARK: - Bookmark
        
        enum Bookmark {
            static let px16gray300 = UIImage(named: "ic_bookmark_16px_300")!.withRenderingMode(.alwaysOriginal) /// gray300
            static let px16gray400 = UIImage(named: "ic_bookmark_16px_400")!.withRenderingMode(.alwaysOriginal) /// gray400
            static let point = UIImage(named: "ic_bookmark")!.withRenderingMode(.alwaysOriginal)
        }
        
        // MARK: - Review
        
        enum Review {
            static let px16 = UIImage(named: "ic_review_16px")!.withRenderingMode(.alwaysOriginal)
            static let point = UIImage(named: "ic_review")!.withRenderingMode(.alwaysOriginal)
            static let px16gray400 = UIImage(named: "ic_review_16px_400")!.withRenderingMode(.alwaysOriginal)
            static let bread = UIImage(named: "ic_review_bread")!.withRenderingMode(.alwaysOriginal)
        }
        
        // MARK: - Search
        
        enum Search {
            static let gray400 = UIImage(named: "ic_search_400")!.withRenderingMode(.alwaysOriginal) /// gray400
            static let gray600 = UIImage(named: "ic_search_600")!.withRenderingMode(.alwaysOriginal) /// gray600
        }
        
        // MARK: - Filter
        
        enum Filter {
            static let check = UIImage(named: "ic_filter_check")!.withRenderingMode(.alwaysOriginal)
            static let uncheck = UIImage(named: "ic_filter_unchecked")!.withRenderingMode(.alwaysOriginal)
        }
        
        // MARK: - Tabbar
        
        enum Home {
            static let disabled = UIImage(named: "ic_home_disable")!.withRenderingMode(.alwaysOriginal)
            static let enabled = UIImage(named: "ic_home_enable")!.withRenderingMode(.alwaysOriginal)
        }
        
        enum Mypage {
            static let disabled = UIImage(named: "ic_mypage_disable")!.withRenderingMode(.alwaysOriginal)
            static let enabled = UIImage(named: "ic_mypage_enable")!.withRenderingMode(.alwaysOriginal)
        }
        
        enum StoreList {
            static let disabled = UIImage(named: "ic_storelist_disable")!.withRenderingMode(.alwaysOriginal)
            static let enabled = UIImage(named: "ic_storelist_enable")!.withRenderingMode(.alwaysOriginal)
        }
        
        // MARK: - others
        
        static let call = UIImage(named: "ic_call")!.withRenderingMode(.alwaysOriginal)
        static let check = UIImage(named: "ic_check")!.withRenderingMode(.alwaysOriginal)
        static let deleteKeyword = UIImage(named: "ic_delete_keyword")!.withRenderingMode(.alwaysOriginal) /// 최근 검색어 삭제용 (앱잼 이후)
        static let delete = UIImage(named: "ic_delete")!.withRenderingMode(.alwaysOriginal)
        static let dotdotdot = UIImage(named: "ic_dotdotdot")!.withRenderingMode(.alwaysOriginal)
        static let hide = UIImage(named: "ic_hide")!.withRenderingMode(.alwaysOriginal)
        static let launchscreen = UIImage(named: "ic_launchscreen")!.withRenderingMode(.alwaysOriginal)
        static let link = UIImage(named: "ic_link")!.withRenderingMode(.alwaysOriginal)
        static let list = UIImage(named: "ic_list")!.withRenderingMode(.alwaysOriginal) // 건빵집 리스트 옆에 얘 써야 됨, 탭바의 storelist 아님!
        static let map = UIImage(named: "ic_map")!.withRenderingMode(.alwaysOriginal)
        static let notice = UIImage(named: "ic_notice_18px")!.withRenderingMode(.alwaysOriginal)
        static let profile = UIImage(named: "ic_profile")!.withRenderingMode(.alwaysOriginal)
        static let show = UIImage(named: "ic_show")!.withRenderingMode(.alwaysOriginal)
        static let store = UIImage(named: "ic_store")!.withRenderingMode(.alwaysOriginal)
        static let swap = UIImage(named: "ic_swap")!.withRenderingMode(.alwaysOriginal)
        static let time = UIImage(named: "ic_time")!.withRenderingMode(.alwaysOriginal)
        static let login = UIImage(named: "ic_login")!.withRenderingMode(.alwaysOriginal)
    }
    
    // MARK: - Environmental Marks
    enum GMO {
        static let mark22 = UIImage(named: "gmo_mark_22px")!.withRenderingMode(.alwaysOriginal)
        static let mark28 = UIImage(named: "gmo_mark_28px")!.withRenderingMode(.alwaysOriginal)
    }
    
    enum HACCP {
        static let mark22 = UIImage(named: "haccp_mark_22px")!.withRenderingMode(.alwaysOriginal)
        static let mark28 = UIImage(named: "haccp_mark_28px")!.withRenderingMode(.alwaysOriginal)
    }
    
    enum Vegan {
        static let mark22 = UIImage(named: "vegan_mark_22px")!.withRenderingMode(.alwaysOriginal)
        static let mark28 = UIImage(named: "vegan_mark_28px")!.withRenderingMode(.alwaysOriginal)
    }
    
    
    // MARK: - Image
    
    enum Image {
        static let noBookmark = UIImage(named: "img_no_bookmark")!.withRenderingMode(.alwaysOriginal)
        static let noMyreview = UIImage(named: "img_no_myreview")!.withRenderingMode(.alwaysOriginal)
        static let noReview = UIImage(named: "img_no_review")!.withRenderingMode(.alwaysOriginal)
        static let noSearchResult = UIImage(named: "img_no_search_result")!.withRenderingMode(.alwaysOriginal)
        static let search = UIImage(named: "img_search")!.withRenderingMode(.alwaysOriginal)
        static let serverMaintenance = UIImage(named: "img_server_maintenance")!.withRenderingMode(.alwaysOriginal)
        static let welcome = UIImage(named: "img_welcome")!.withRenderingMode(.alwaysOriginal)
        
        enum Bubble {
            static let left = UIImage(named: "img_left_bubble")!.withRenderingMode(.alwaysOriginal)
            static let right = UIImage(named: "img_right_bubble")!.withRenderingMode(.alwaysOriginal)
        }
        
        enum Loading {
            static let large = UIImage(named: "img_loading_large")!.withRenderingMode(.alwaysOriginal)
            static let medium = UIImage(named: "img_loading_medium")!.withRenderingMode(.alwaysOriginal)
            static let small = UIImage(named: "img_loading_small")!.withRenderingMode(.alwaysOriginal)
        }
    }
    
    
    // MARK: - Button
    
    static let disabledBookmarkButton = UIImage(named: "bookmark_button_disable")!.withRenderingMode(.alwaysOriginal)
    static let enabledBookmarkButton = UIImage(named: "bookmark_button_enable")!.withRenderingMode(.alwaysOriginal)
    static let copyButton = UIImage(named: "copy_button")!.withRenderingMode(.alwaysOriginal)
    static let homeFilterButton = UIImage(named: "home_filter_button")!.withRenderingMode(.alwaysOriginal)
    static let mapButton = UIImage(named: "map_button")!.withRenderingMode(.alwaysOriginal)
    static let bakeryFilterButton = UIImage(named: "bakery_filter_button")!.withRenderingMode(.alwaysOriginal)
    
    // Social Login
    static let kakaoLoginButton = UIImage(named: "KakaoSocialLogin")!.withRenderingMode(.alwaysOriginal)
    static let appleLoginButton = UIImage(named: "AppleSocialLogin")!.withRenderingMode(.alwaysOriginal)
}

extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
