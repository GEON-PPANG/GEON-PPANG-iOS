//
//  UIImage+.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/03.
//

import UIKit

extension UIImage {
    
    // 따로 픽셀이 적혀있지 않은 컴포넌트는 24px임.
    
    // Bread Types
    static let icCakeDisable20px = UIImage(named: "ic_cake_disable_20px")!.withRenderingMode(.alwaysOriginal)
    static let icHardDisable20px = UIImage(named: "ic_hard_disable_20px")!.withRenderingMode(.alwaysOriginal)
    static let icSandwichDisable20px = UIImage(named: "ic_sandwich_disable_20px")!.withRenderingMode(.alwaysOriginal)
    static let icCakeEnable20px = UIImage(named: "ic_cake_enable_20px")!.withRenderingMode(.alwaysOriginal)
    static let icHardEnable20px = UIImage(named: "ic_hard_enable_20px")!.withRenderingMode(.alwaysOriginal)
    static let icSandwichEnable20px = UIImage(named: "ic_sandwich_enable_20px")!.withRenderingMode(.alwaysOriginal)
    
    // Emoji
    
    static let iconSad = UIImage(named: "icon_sad")!.withRenderingMode(.alwaysOriginal)
    static let iconCrying = UIImage(named: "icon_crying")!.withRenderingMode(.alwaysOriginal)
    
    // Environmental Marks
    static let gmoMark22px = UIImage(named: "gmo_mark_22px")!.withRenderingMode(.alwaysOriginal)
    static let haccpMark22px = UIImage(named: "haccp_mark_22px")!.withRenderingMode(.alwaysOriginal)
    static let veganMark22px = UIImage(named: "vegan_mark_22px")!.withRenderingMode(.alwaysOriginal)
    static let gmoMark28px = UIImage(named: "gmo_mark_28px")!.withRenderingMode(.alwaysOriginal)
    static let haccpMark28px = UIImage(named: "haccp_mark_28px")!.withRenderingMode(.alwaysOriginal)
    static let veganMark28px = UIImage(named: "vegan_mark_28px")!.withRenderingMode(.alwaysOriginal)
    
    // Icons
    static let icArrowDown = UIImage(named: "ic_arrow_down")!.withRenderingMode(.alwaysOriginal)
    static let icArrowLeft = UIImage(named: "ic_arrow_left")!.withRenderingMode(.alwaysOriginal)
    static let icArrowRight = UIImage(named: "ic_arrow_right")!.withRenderingMode(.alwaysOriginal)
    static let icArrowUp = UIImage(named: "ic_arrow_up")!.withRenderingMode(.alwaysOriginal)
    static let icBookmark16px300 = UIImage(named: "ic_bookmark_16px_300")!.withRenderingMode(.alwaysOriginal) /// gray300
    static let icBookmark16px400 = UIImage(named: "ic_bookmark_16px_400")!.withRenderingMode(.alwaysOriginal) /// gray400
    static let icBookmark = UIImage(named: "ic_bookmark")!.withRenderingMode(.alwaysOriginal)
    static let icCall = UIImage(named: "ic_call")!.withRenderingMode(.alwaysOriginal)
    static let icCheck = UIImage(named: "ic_check")!.withRenderingMode(.alwaysOriginal)
    static let icDeleteKeyword = UIImage(named: "ic_delete_keyword")!.withRenderingMode(.alwaysOriginal) /// 최근 검색어 삭제용 (앱잼 이후)
    static let icDelete = UIImage(named: "ic_delete")!.withRenderingMode(.alwaysOriginal)
    static let icDotdotdot = UIImage(named: "ic_dotdotdot")!.withRenderingMode(.alwaysOriginal)
    static let icHide = UIImage(named: "ic_hide")!.withRenderingMode(.alwaysOriginal)
    static let icLaunchscreen = UIImage(named: "ic_launchscreen")!.withRenderingMode(.alwaysOriginal)
    static let icLink = UIImage(named: "ic_link")!.withRenderingMode(.alwaysOriginal)
    static let icList = UIImage(named: "ic_list")!.withRenderingMode(.alwaysOriginal) // 건빵집 리스트 옆에 얘 써야 됨, 탭바의 storelist 아님!
    static let icLogo16px = UIImage(named: "ic_logo_16px")!.withRenderingMode(.alwaysOriginal)
    static let icLogo20px = UIImage(named: "ic_logo_20px")!.withRenderingMode(.alwaysOriginal)
    static let icMap = UIImage(named: "ic_map")!.withRenderingMode(.alwaysOriginal)
    static let icNotice18px = UIImage(named: "ic_notice_18px")!.withRenderingMode(.alwaysOriginal)
    static let icProfile = UIImage(named: "ic_profile")!.withRenderingMode(.alwaysOriginal)
    static let icReview16px = UIImage(named: "ic_review_16px")!.withRenderingMode(.alwaysOriginal)
    static let icReview = UIImage(named: "ic_review")!.withRenderingMode(.alwaysOriginal)
    static let icReview16px400 = UIImage(named: "ic_review_16px_400")!.withRenderingMode(.alwaysOriginal)
    static let icReviewBread = UIImage(named: "ic_review_bread")!.withRenderingMode(.alwaysOriginal)
    static let icSearch400 = UIImage(named: "ic_search_400")!.withRenderingMode(.alwaysOriginal) /// gray400
    static let icSearch600 = UIImage(named: "ic_search_600")!.withRenderingMode(.alwaysOriginal) /// gray600
    static let icSmile = UIImage(named: "ic_smile")!.withRenderingMode(.alwaysOriginal)
    static let icShow = UIImage(named: "ic_show")!.withRenderingMode(.alwaysOriginal)
    static let icSmile86px = UIImage(named: "ic_smile_86px")!.withRenderingMode(.alwaysOriginal)
    static let icStore = UIImage(named: "ic_store")!.withRenderingMode(.alwaysOriginal)
    static let icSwap = UIImage(named: "ic_swap")!.withRenderingMode(.alwaysOriginal)
    static let icTime = UIImage(named: "ic_time")!.withRenderingMode(.alwaysOriginal)
    static let icFilterCheck = UIImage(named: "ic_filter_check")!.withRenderingMode(.alwaysOriginal)
    static let icFilterUnchecked = UIImage(named: "ic_filter_unchecked")!.withRenderingMode(.alwaysOriginal)
    static let icLogin = UIImage(named: "ic_login")!.withRenderingMode(.alwaysOriginal)
    
    // Images
    static let imgNoBookmark = UIImage(named: "img_no_bookmark")!.withRenderingMode(.alwaysOriginal)
    static let imgNoMyreview = UIImage(named: "img_no_myreview")!.withRenderingMode(.alwaysOriginal)
    static let imgNoReview = UIImage(named: "img_no_review")!.withRenderingMode(.alwaysOriginal)
    static let imgNoSearchResult = UIImage(named: "img_no_search_result")!.withRenderingMode(.alwaysOriginal)
    static let imgSearch = UIImage(named: "img_search")!.withRenderingMode(.alwaysOriginal)
    static let imgServerMaintenance = UIImage(named: "img_server_maintenance")!.withRenderingMode(.alwaysOriginal)
    static let imgWelcome = UIImage(named: "img_welcome")!.withRenderingMode(.alwaysOriginal)
    static let imgLeftBubble = UIImage(named: "img_left_bubble")!.withRenderingMode(.alwaysOriginal)
    static let imgRightBubble = UIImage(named: "img_right_bubble")!.withRenderingMode(.alwaysOriginal)
    static let imgLoadingLarge = UIImage(named: "img_loading_large")!.withRenderingMode(.alwaysOriginal)
    static let imgLoadingMedium = UIImage(named: "img_loading_medium")!.withRenderingMode(.alwaysOriginal)
    static let imgLoadingSmall = UIImage(named: "img_loading_small")!.withRenderingMode(.alwaysOriginal)
        
    static let icSearch48px = UIImage(named: "ic_search_48px")!.withRenderingMode(.alwaysOriginal)
    
    // Ready-made Buttons
    static let bookmarkButtonDisable = UIImage(named: "bookmark_button_disable")!.withRenderingMode(.alwaysOriginal)
    static let bookmarkButtonEnable = UIImage(named: "bookmark_button_enable")!.withRenderingMode(.alwaysOriginal)
    static let copyButton = UIImage(named: "copy_button")!.withRenderingMode(.alwaysOriginal)
    static let homeFilterButton = UIImage(named: "home_filter_button")!.withRenderingMode(.alwaysOriginal)
    static let mapButton = UIImage(named: "map_button")!.withRenderingMode(.alwaysOriginal)
    static let bakeryFilterButton = UIImage(named: "bakery_filter_button")!.withRenderingMode(.alwaysOriginal)
    
    // Social Login
    static let kakaoSociaLogin = UIImage(named: "KakaoSocialLogin")!.withRenderingMode(.alwaysOriginal)
    static let appleSocialLogin = UIImage(named: "AppleSocialLogin")!.withRenderingMode(.alwaysOriginal)
    
    // TabBar
    static let icHomeDisable = UIImage(named: "ic_home_disable")!.withRenderingMode(.alwaysOriginal)
    static let icMypageDisable = UIImage(named: "ic_mypage_disable")!.withRenderingMode(.alwaysOriginal)
    static let icStorelistDisable = UIImage(named: "ic_storelist_disable")!.withRenderingMode(.alwaysOriginal)
    static let icHomeEnable = UIImage(named: "ic_home_enable")!.withRenderingMode(.alwaysOriginal)
    static let icMypageEnable = UIImage(named: "ic_mypage_enable")!.withRenderingMode(.alwaysOriginal)
    static let icStorelistEnable = UIImage(named: "ic_storelist_enable")!.withRenderingMode(.alwaysOriginal)
}

extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
