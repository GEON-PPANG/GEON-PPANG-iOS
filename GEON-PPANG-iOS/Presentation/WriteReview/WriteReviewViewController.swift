//
//  WriteReviewViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/06.
//

import UIKit

import SnapKit
import Then

final class WriteReviewViewController: BaseViewController {
    
    // MARK: - Property
    
    
    
    // MARK: - UI Property
    
    // TODO: navigationBar 추가
    private let bakeryOverviewView = BakeryOverviewView(bakeryImage: .actions, regions: ["tset", "efqerqf"])
    
    
    // MARK: - Setting
    
    override func setLayout() {
        view.addSubview(bakeryOverviewView)
        bakeryOverviewView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(125)
        }
    }
    
}
