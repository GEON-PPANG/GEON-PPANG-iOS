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
    static let disabledCakeIcon = UIImage(named: "ic_cake_disable_20px")!.withRenderingMode(.alwaysOriginal)
    static let disabledHardIcon = UIImage(named: "ic_hard_disable_20px")!.withRenderingMode(.alwaysOriginal)
    static let disabledSandwichIcon = UIImage(named: "ic_sandwich_disable_20px")!.withRenderingMode(.alwaysOriginal)
    static let enabledCakeIcon = UIImage(named: "ic_cake_enable_20px")!.withRenderingMode(.alwaysOriginal)
    static let enabledHardIcon = UIImage(named: "ic_hard_enable_20px")!.withRenderingMode(.alwaysOriginal)
    static let enabledSandwichIcon = UIImage(named: "ic_sandwich_enable_20px")!.withRenderingMode(.alwaysOriginal)
    
    // Emoji
    
    static let sadIcon = UIImage(named: "icon_sad")!.withRenderingMode(.alwaysOriginal)
    static let cryingIcon = UIImage(named: "icon_crying")!.withRenderingMode(.alwaysOriginal)
    
    // Environmental Marks
    static let smallGMOMark = UIImage(named: "gmo_mark_22px")!.withRenderingMode(.alwaysOriginal)
    static let smallHACCPMark = UIImage(named: "haccp_mark_22px")!.withRenderingMode(.alwaysOriginal)
    static let smallVeganMark = UIImage(named: "vegan_mark_22px")!.withRenderingMode(.alwaysOriginal)
    static let bigGMOMark = UIImage(named: "gmo_mark_28px")!.withRenderingMode(.alwaysOriginal)
    static let bigHACCPMark = UIImage(named: "haccp_mark_28px")!.withRenderingMode(.alwaysOriginal)
    static let bigVeganMark = UIImage(named: "vegan_mark_28px")!.withRenderingMode(.alwaysOriginal)
    
    // Icons
    static let downArrowIcon = UIImage(named: "ic_arrow_down")!.withRenderingMode(.alwaysOriginal)
    static let leftArrowIcon = UIImage(named: "ic_arrow_left")!.withRenderingMode(.alwaysOriginal)
    static let rightArrowIcon = UIImage(named: "ic_arrow_right")!.withRenderingMode(.alwaysOriginal)
    static let upArrowIcon = UIImage(named: "ic_arrow_up")!.withRenderingMode(.alwaysOriginal)
    static let bookmarkIcon16px300 = UIImage(named: "ic_bookmark_16px_300")!.withRenderingMode(.alwaysOriginal) /// gray300
    static let bookmarkIcon16px400 = UIImage(named: "ic_bookmark_16px_400")!.withRenderingMode(.alwaysOriginal) /// gray400
    static let bookmarkIcon = UIImage(named: "ic_bookmark")!.withRenderingMode(.alwaysOriginal)
    static let callIcon = UIImage(named: "ic_call")!.withRenderingMode(.alwaysOriginal)
    static let checkIcon = UIImage(named: "ic_check")!.withRenderingMode(.alwaysOriginal)
    static let deleteKeywordIcon = UIImage(named: "ic_delete_keyword")!.withRenderingMode(.alwaysOriginal) /// 최근 검색어 삭제용 (앱잼 이후)
    static let deleteIcon = UIImage(named: "ic_delete")!.withRenderingMode(.alwaysOriginal)
    static let dotdotdotIcon = UIImage(named: "ic_dotdotdot")!.withRenderingMode(.alwaysOriginal)
    static let hideIcon = UIImage(named: "ic_hide")!.withRenderingMode(.alwaysOriginal)
    static let launchscreenIcon = UIImage(named: "ic_launchscreen")!.withRenderingMode(.alwaysOriginal)
    static let linkIcon = UIImage(named: "ic_link")!.withRenderingMode(.alwaysOriginal)
    static let listIcon = UIImage(named: "ic_list")!.withRenderingMode(.alwaysOriginal) // 건빵집 리스트 옆에 얘 써야 됨, 탭바의 storelist 아님!
    static let logoIcon16px = UIImage(named: "ic_logo_16px")!.withRenderingMode(.alwaysOriginal)
    static let logoIcon20px = UIImage(named: "ic_logo_20px")!.withRenderingMode(.alwaysOriginal)
    static let mapIcon = UIImage(named: "ic_map")!.withRenderingMode(.alwaysOriginal)
    static let noticeIcon18px = UIImage(named: "ic_notice_18px")!.withRenderingMode(.alwaysOriginal)
    static let profileIcon = UIImage(named: "ic_profile")!.withRenderingMode(.alwaysOriginal)
    static let reviewIcon16px = UIImage(named: "ic_review_16px")!.withRenderingMode(.alwaysOriginal)
    static let reviewIcon = UIImage(named: "ic_review")!.withRenderingMode(.alwaysOriginal)
    static let reviewIcon16px400 = UIImage(named: "ic_review_16px_400")!.withRenderingMode(.alwaysOriginal)
    static let reviewBreadIcon = UIImage(named: "ic_review_bread")!.withRenderingMode(.alwaysOriginal)
    static let searchIcon400 = UIImage(named: "ic_search_400")!.withRenderingMode(.alwaysOriginal) /// gray400
    static let searchIcon600 = UIImage(named: "ic_search_600")!.withRenderingMode(.alwaysOriginal) /// gray600
    static let smileIcon = UIImage(named: "ic_smile")!.withRenderingMode(.alwaysOriginal)
    static let showIcon = UIImage(named: "ic_show")!.withRenderingMode(.alwaysOriginal)
    static let smileIcon86px = UIImage(named: "ic_smile_86px")!.withRenderingMode(.alwaysOriginal)
    static let storeIcon = UIImage(named: "ic_store")!.withRenderingMode(.alwaysOriginal)
    static let swapIcon = UIImage(named: "ic_swap")!.withRenderingMode(.alwaysOriginal)
    static let timeIcon = UIImage(named: "ic_time")!.withRenderingMode(.alwaysOriginal)
    static let filterCheckIcon = UIImage(named: "ic_filter_check")!.withRenderingMode(.alwaysOriginal)
    static let filterUncheckIcon = UIImage(named: "ic_filter_unchecked")!.withRenderingMode(.alwaysOriginal)
    static let loginIcon = UIImage(named: "ic_login")!.withRenderingMode(.alwaysOriginal)
    
    // Images
    static let noBookmarkImage = UIImage(named: "img_no_bookmark")!.withRenderingMode(.alwaysOriginal)
    static let noMyreviewImage = UIImage(named: "img_no_myreview")!.withRenderingMode(.alwaysOriginal)
    static let noReviewImage = UIImage(named: "img_no_review")!.withRenderingMode(.alwaysOriginal)
    static let noSearchResultImage = UIImage(named: "img_no_search_result")!.withRenderingMode(.alwaysOriginal)
    static let searchImage = UIImage(named: "img_search")!.withRenderingMode(.alwaysOriginal)
    static let serverMaintenanceImage = UIImage(named: "img_server_maintenance")!.withRenderingMode(.alwaysOriginal)
    static let welcomeImage = UIImage(named: "img_welcome")!.withRenderingMode(.alwaysOriginal)
    static let leftBubbleImage = UIImage(named: "img_left_bubble")!.withRenderingMode(.alwaysOriginal)
    static let rightBubbleImage = UIImage(named: "img_right_bubble")!.withRenderingMode(.alwaysOriginal)
    static let loading_large = UIImage(named: "img_loading_large")!.withRenderingMode(.alwaysOriginal)
    static let loading_medium = UIImage(named: "img_loading_medium")!.withRenderingMode(.alwaysOriginal)
    static let loading_small = UIImage(named: "img_loading_small")!.withRenderingMode(.alwaysOriginal)
        
    // Include Touch Area
    static let bigLeftArrowIcon = UIImage(named: "ic_arrow_left")!.withRenderingMode(.alwaysOriginal)
    static let bigRightArrowIcon = UIImage(named: "ic_arrow_right")!.withRenderingMode(.alwaysOriginal)
    static let bigSearchIcon = UIImage(named: "ic_search_48px")!.withRenderingMode(.alwaysOriginal)
    
    // Ready-made Buttons
    static let disabledBookmarkButton = UIImage(named: "bookmark_button_disable")!.withRenderingMode(.alwaysOriginal)
    static let enabledBookmarkButton = UIImage(named: "bookmark_button_enable")!.withRenderingMode(.alwaysOriginal)
    static let copyButton = UIImage(named: "copy_button")!.withRenderingMode(.alwaysOriginal)
    static let homeFilterButton = UIImage(named: "home_filter_button")!.withRenderingMode(.alwaysOriginal)
    static let mapButton = UIImage(named: "map_button")!.withRenderingMode(.alwaysOriginal)
    static let bakeryFilterButton = UIImage(named: "bakery_filter_button")!.withRenderingMode(.alwaysOriginal)
    
    // Social Login
    static let kakaoLoginButton = UIImage(named: "KakaoSocialLogin")!.withRenderingMode(.alwaysOriginal)
    static let appleLoginButton = UIImage(named: "AppleSocialLogin")!.withRenderingMode(.alwaysOriginal)
    
    // TabBar
    static let disabledHomeIcon = UIImage(named: "ic_home_disable")!.withRenderingMode(.alwaysOriginal)
    static let disabledMypageIcon = UIImage(named: "ic_mypage_disable")!.withRenderingMode(.alwaysOriginal)
    static let disabledStorelistIcon = UIImage(named: "ic_storelist_disable")!.withRenderingMode(.alwaysOriginal)
    static let enabledHomeIcon = UIImage(named: "ic_home_enable")!.withRenderingMode(.alwaysOriginal)
    static let enabledMypageIcon = UIImage(named: "ic_mypage_enable")!.withRenderingMode(.alwaysOriginal)
    static let enabledStorelistIcon = UIImage(named: "ic_storelist_enable")!.withRenderingMode(.alwaysOriginal)
}

extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
