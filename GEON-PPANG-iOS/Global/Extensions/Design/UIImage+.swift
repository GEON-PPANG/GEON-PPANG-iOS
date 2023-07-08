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
    static let disabledCakeIcon = UIImage(named: "ic_cake_disable_20px")
    static let disabledHardIcon = UIImage(named: "ic_hard_disable_20px")
    static let disabledSandwichIcon = UIImage(named: "ic_sandwich_disable_20px")
    static let enabledCakeIcon = UIImage(named: "ic_cake_enable_20px")
    static let enabledHardIcon = UIImage(named: "ic_hard_enable_20px")
    static let enabledSandwichIcon = UIImage(named: "ic_sandwich_enable_20px")
    
    // Emoji
    static let memoEmoji = UIImage(named: "memo_32px")
    static let sadEmoji = UIImage(named: "sad_32px")
    static let smileEmoji = UIImage(named: "smile_32px")
    
    // Environmental Marks
    static let smallGMOMark = UIImage(named: "gmo_mark_22px")
    static let smallHACCPMark = UIImage(named: "haccp_mark_22px")
    static let smallVeganMark = UIImage(named: "vegan_mark_22px")
    static let bigGMOMark = UIImage(named: "gmo_mark_28px")
    static let bigHACCPMark = UIImage(named: "haccp_mark_28px")
    static let bigVeganMark = UIImage(named: "vegan_mark_28px")
    
    // Icons
    static let leftArrowIcon = UIImage(named: "ic_arrow_left")
    static let rightArrowIcon = UIImage(named: "ic_arrow_right")
    static let bookmarkIcon = UIImage(named: "ic_bookmark")
    static let callIcon = UIImage(named: "ic_call")
    static let checkIcon = UIImage(named: "ic_check")
    static let deleteKeywordIcon = UIImage(named: "ic_delete_keyword") // 최근 검색어 삭제용 (앱잼 이후)
    static let deleteIcon = UIImage(named: "ic_delete")
    static let dotdotdotIcon = UIImage(named: "ic_dotdotdot")
    static let hideIcon = UIImage(named: "ic_hide")
    static let linkIcon = UIImage(named: "ic_link")
    static let logoIcon16px = UIImage(named: "ic_logo_16px")
    static let noticeIcon = UIImage(named: "ic_notice")
    static let reviewIcon = UIImage(named: "ic_review")
    static let searchIcon400 = UIImage(named: "ic_search_400") // gray400
    static let searchIcon600 = UIImage(named: "ic_search_600") // gray600
    static let showIcon = UIImage(named: "ic_show")
    static let storeIcon = UIImage(named: "ic_store")
    static let swapIcon = UIImage(named: "ic_swap")
    
    // Include Touch Area
    static let bigLeftArrowIcon = UIImage(named: "ic_arrow_left")
    static let bigRightArrowIcon = UIImage(named: "ic_arrow_right")
    static let bigSearchIcon = UIImage(named: "ic_search_48px")
    
    // Ready-made Buttons
    static let disabledBookmarkButton = UIImage(named: "bookmark_button_disable")
    static let enabledBookmarkButton = UIImage(named: "bookmark_button_enable")
    static let copyButton = UIImage(named: "copy_button")
    static let homeFilterButton = UIImage(named: "home_filter_button")
    static let mapButton = UIImage(named: "map_button")
    
    // Social Login
    static let appleLoginButton = UIImage(named: "apple_login_button_56px")
    static let googleLoginButton = UIImage(named: "google_login_button_56px")
    static let kakaoLoginButton = UIImage(named: "kakao_login_button_56px")
    static let naverLoginButton = UIImage(named: "naver_login_button_56px")
    
    // TabBar
    static let disabledHomeIcon = UIImage(named: "ic_home_disable")
    static let disabledMypageIcon = UIImage(named: "ic_mypage_disable")
    static let disabledStorelistIcon = UIImage(named: "ic_storelist_disable")
    static let enabledHomeIcon = UIImage(named: "ic_home_enable")
    static let enabledMypageIcon = UIImage(named: "ic_mypage_enable")
    static let enabledStorelistIcon = UIImage(named: "ic_storelist_enable")
}
