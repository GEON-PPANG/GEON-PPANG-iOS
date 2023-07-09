//
//  HomeViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/08.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    // MARK: - Property
    
    lazy var safeArea = self.view.safeAreaLayoutGuide
    
    // MARK: - UI Property
    
    private let topView = HomeTopView()
    
    // MARK: - Life Cycle
    
    override func setUI() {
        self.do {
            $0.view.backgroundColor = .white
        }
        
        topView.do {
            $0.setTitle("정둥어")
            $0.gotoNextView = {
                Utils.push(self.navigationController, SearchViewController())
            }
        }
    }
    
    override func setLayout() {
        view.addSubviews(topView)
        
        topView.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(16)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(convertByHeightRatio(200))
        }
    }
    
    // MARK: - Setting

}
