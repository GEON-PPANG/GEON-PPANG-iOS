//
//  TabBarItem.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/08.
//

import UIKit

enum TabBarItemType: Int, CaseIterable {
    case home
    case bakeryList
    case mypage
}

extension TabBarItemType {
    var selectedIcon: UIImage {
        switch self {
        case .home:
            return .icHomeEnable
        case .bakeryList:
            return .icStorelistEnable
        case .mypage:
            return .icMypageEnable
        }
    }
    
    var unselectedIcon: UIImage {
        switch self {
        case .home:
            return .icHomeDisable
        case .bakeryList:
            return .icStorelistDisable
        case .mypage:
            return .icMypageDisable
        }
    }
    
    var tabBarTitle: String {
        switch self {
        case .home:
            return "홈"
        case .bakeryList:
            return "건빵집리스트"
        case .mypage:
            return "마이페이지"
        }
    }
    
    public func setTabBarItem() -> UITabBarItem {
        return UITabBarItem(
            title: tabBarTitle,
            image: unselectedIcon,
            selectedImage: selectedIcon
        )
    }    
}
