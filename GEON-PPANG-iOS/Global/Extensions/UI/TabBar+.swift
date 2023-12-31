//
//  TabBar+.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/08.
//

import UIKit

extension UITabBar {
    
    func configureTabBarUI() {
        
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBarItem.appearance().titlePositionAdjustment.vertical = -5
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.captionB1!,
                                                          NSAttributedString.Key.foregroundColor: UIColor.gbbGray400!],
                                                         for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.captionB1!,
                                                          NSAttributedString.Key.foregroundColor: UIColor.gbbMain3!],
                                                         for: .selected)
    }
}
