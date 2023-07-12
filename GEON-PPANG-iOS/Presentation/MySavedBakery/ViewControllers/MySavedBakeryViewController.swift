//
//  MySavedBakeryViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class MySavedBakeryViewController: BaseViewController {
    
    // MARK: - Property
    
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    // MARK: - UI Property
    
    private let naviView = CustomNavigationBar()
        
    // MARK: - Setting
    
    override func setLayout() {
        view.addSubview(naviView)
        
        naviView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalTo(safeArea)
        }
    }
    
    override func setUI() {
        naviView.do {
            $0.addBackButtonAction(UIAction { _ in
                self.navigationController?.popToViewController(self, animated: true)
            })
            $0.configureLeftTitle(to: I18N.MySavedBakery.naviTitle)
        }
    }
}
