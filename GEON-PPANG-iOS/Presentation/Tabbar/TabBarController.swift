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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBar.configureTabBarUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarDelegate()
        setTabBarItems()
        setTabBarUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setTabBarHeight()
    }
    
    // MARK: - Setting
    
    private func setTabBarDelegate() {
        self.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
    }
    
    private func setTabBarItems() {
        
        tabs = [
            HomeViewController(),
            BakeryListViewController(),
            MyPageViewController()
        ]
        
        TabBarItemType.allCases.forEach {
            tabs[$0.rawValue].tabBarItem = $0.setTabBarItem()
            tabs[$0.rawValue].tabBarItem.tag = $0.rawValue
        }
        setViewControllers(tabs, animated: false)
    }
    
    private func setTabBarUI() {
        
        tabBar.tintColor = .gbbMain3
        tabBar.layer.applyShadow()
    }
    
    private func setTabBarHeight() {
        
        let newTabBarHeight = defaultTabBarHeight + convertByHeightRatio(13)
        
        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.origin.y = view.frame.size.height - newTabBarHeight
        
        tabBar.frame = newFrame
    }
}
