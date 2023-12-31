//
//  BaseViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/04.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Property
    
    lazy var safeArea = self.view.safeAreaLayoutGuide
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        setLayout()
        setUI()
        setDelegate()
    }
    
    // MARK: - Setting
    
    private func setBackgroundColor() {
        self.view.backgroundColor = .white
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
