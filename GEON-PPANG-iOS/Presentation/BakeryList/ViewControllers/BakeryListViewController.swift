//
//  BakeryListViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/08.
//

import UIKit

import SnapKit
import Then

final class BakeryListViewController: BaseViewController {
        
    // MARK: - Property
    
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    // MARK: - UI Property
    
    private let bakeryTopView = BakeryListTopView()
    private let bakeryFilterView = BakeryFilterView()

    // MARK: - Life Cycle
    
    override func setUI() {
        bakeryFilterView.do {
            $0.backgroundColor = .clear
        }
    }
    
    override func setLayout() {
        view.addSubviews(bakeryTopView, bakeryFilterView)
        
        bakeryTopView.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(convertByHeightRatio(91))
        }
        bakeryFilterView.snp.makeConstraints {
            $0.top.equalTo(bakeryTopView.snp.bottom)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(convertByHeightRatio(72))
        }
    }
}
