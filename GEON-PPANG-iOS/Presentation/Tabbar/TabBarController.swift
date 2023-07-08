//
//  TabBarController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/08.
//

import UIKit

final class TabBarController: UITabBarController {

    // MARK: - Property
    
    private var tabs: [UIViewController] = []
    private lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBarItems()
        setTabBarUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setTabBarHeight()
    }
    
    // MARK: - Setting

    private func setTabBarItems() {
        tabs = [HomeViewController(),
                BakeryListViewController(),
                MyPageViewController()
                ]
        
        setViewControllers(tabs, animated: false)
    }
    
    private func setTabBarUI() {
        tabBar.backgroundColor = .white
        tabBar.layer.cornerRadius = convertByHeightRatio(12)
        tabBar.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        tabBar.itemPositioning = .centered
    }
    
    private func setTabBarHeight() {
        let newTabBarHeight = defaultTabBarHeight + convertByHeightRatio(13)
        
        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.origin.y = view.frame.size.height - newTabBarHeight

        tabBar.frame = newFrame
    }
}
