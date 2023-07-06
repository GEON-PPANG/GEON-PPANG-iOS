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
    private lazy var regionStackView = RegionStackView(regions: ["tset"])
    
    // MARK: - Setting
    
    override func setLayout() {
        view.addSubview(regionStackView)
        regionStackView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
