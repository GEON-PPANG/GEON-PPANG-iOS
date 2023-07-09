//
//  BaseViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/04.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        setConfigure()
        setLayout()
        setUI()
        setDelegate()
    }
    
    // MARK: - Setting
    
    private func setBackgroundColor() {
        self.view.backgroundColor = .gbbBackground2
    }
    
    private func setConfigure() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setLayout() {
        // override to use
    }
    
    func setUI() {
        // override to use
    }
    
    func setDelegate() {
        // override to use
    }
    
}
