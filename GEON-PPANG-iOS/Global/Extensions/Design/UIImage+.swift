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
    static let memoEmoji = UIImage(named: "memo_32px")!.withRenderingMode(.alwaysOriginal)
    static let sadEmoji = UIImage(named: "sad_32px")!.withRenderingMode(.alwaysOriginal)
    static let smileEmoji = UIImage(named: "smile_32px")!.withRenderingMode(.alwaysOriginal)
    
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
    static let bookmarkIcon = UIImage(named: "ic_bookmark")!.withRenderingMode(.alwaysOriginal)
    static let callIcon = UIImage(named: "ic_call")!.withRenderingMode(.alwaysOriginal)
    static let checkIcon = UIImage(named: "ic_check")!.withRenderingMode(.alwaysOriginal)
    static let deleteKeywordIcon = UIImage(named: "ic_delete_keyword")!.withRenderingMode(.alwaysOriginal) // 최근 검색어 삭제용 (앱잼 이후)
    static let deleteIcon = UIImage(named: "ic_delete")!.withRenderingMode(.alwaysOriginal)
    static let dotdotdotIcon = UIImage(named: "ic_dotdotdot")!.withRenderingMode(.alwaysOriginal)
    static let hideIcon = UIImage(named: "ic_hide")!.withRenderingMode(.alwaysOriginal)
    static let linkIcon = UIImage(named: "ic_link")!.withRenderingMode(.alwaysOriginal)
    static let listIcon = UIImage(named: "ic_list")!.withRenderingMode(.alwaysOriginal) // 건빵집 리스트 옆에 얘 써야 됨, 탭바의 storelist 아님!
    static let logoIcon16px = UIImage(named: "ic_logo_16px")!.withRenderingMode(.alwaysOriginal)
    static let noticeIcon18px = UIImage(named: "ic_notice_18px")!.withRenderingMode(.alwaysOriginal)
    static let reviewIcon = UIImage(named: "ic_review")!.withRenderingMode(.alwaysOriginal)
    static let searchIcon400 = UIImage(named: "ic_search_400")!.withRenderingMode(.alwaysOriginal) // gray400
    static let searchIcon600 = UIImage(named: "ic_search_600")!.withRenderingMode(.alwaysOriginal) // gray600
    static let showIcon = UIImage(named: "ic_show")!.withRenderingMode(.alwaysOriginal)
    static let storeIcon = UIImage(named: "ic_store")!.withRenderingMode(.alwaysOriginal)
    static let swapIcon = UIImage(named: "ic_swap")!.withRenderingMode(.alwaysOriginal)
    static let timeIcon = UIImage(named: "ic_time")!.withRenderingMode(.alwaysOriginal)
    
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
    
    // Social Login
    static let appleLoginButton = UIImage(named: "apple_login_button_56px")!.withRenderingMode(.alwaysOriginal)
    static let googleLoginButton = UIImage(named: "google_login_button_56px")!.withRenderingMode(.alwaysOriginal)
    static let kakaoLoginButton = UIImage(named: "kakao_login_button_56px")!.withRenderingMode(.alwaysOriginal)
    static let naverLoginButton = UIImage(named: "naver_login_button_56px")!.withRenderingMode(.alwaysOriginal)
    
    // TabBar
    static let disabledHomeIcon = UIImage(named: "ic_home_disable")!.withRenderingMode(.alwaysOriginal)
    static let disabledMypageIcon = UIImage(named: "ic_mypage_disable")!.withRenderingMode(.alwaysOriginal)
    static let disabledStorelistIcon = UIImage(named: "ic_storelist_disable")!.withRenderingMode(.alwaysOriginal)
    static let enabledHomeIcon = UIImage(named: "ic_home_enable")!.withRenderingMode(.alwaysOriginal)
    static let enabledMypageIcon = UIImage(named: "ic_mypage_enable")!.withRenderingMode(.alwaysOriginal)
    static let enabledStorelistIcon = UIImage(named: "ic_storelist_enable")!.withRenderingMode(.alwaysOriginal)
}
