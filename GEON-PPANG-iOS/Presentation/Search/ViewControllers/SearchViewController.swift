//
//  SearchViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/09.
//

import UIKit

import SnapKit
import Then

final class SearchViewController: BaseViewController {
    
    // MARK: - Property
    
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    // MARK: - UI Property
    
    private let naviView = SearchNavigationView()
    private let searchResultView = SearchResultView()
    
    // MARK: - Setting
    
    override func setLayout() {
        view.addSubviews(naviView, searchResultView)
        
        naviView.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(convertByHeightRatio(68))
        }
        
        searchResultView.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(convertByHeightRatio(55))
        }
    }
    
    override func setUI() {
        naviView.do {
            $0.dismissClosure = {
                self.navigationController?.popViewController(animated: true)
            }
        }
        searchResultView.do {
            $0.updateUI(count: 3)
        }
    }
}
