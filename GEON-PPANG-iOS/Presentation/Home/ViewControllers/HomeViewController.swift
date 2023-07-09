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
    private let label = UILabel()
    
    // MARK: - Life Cycle
    
    func searchText(_ text: String) {
        label.text = text
    }
    
    override func setUI() {
        self.do {
            $0.view.backgroundColor = .white
        }
        
        topView.do {
            $0.setTitle("정둥어")
            $0.gotoNextView = {
                Utils.push(self.navigationController, SearchViewController())
            }
        
            label.do {
                $0.font = .pretendardBold(15)
            }
        }
    }
    
    override func setLayout() {
        view.addSubviews(topView, label)
        
        topView.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(16)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(convertByHeightRatio(200))
        }
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Setting

}
