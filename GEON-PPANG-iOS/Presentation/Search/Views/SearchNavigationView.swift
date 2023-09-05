//
//  SearchNavigationView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class SearchNavigationView: UIView {
    
    // MARK: - Property
    
    var dismissSearchView: (() -> Void)?
    var fetchBakeryList: ((String) -> Void)?
    
    // MARK: - UI Property
    
    private lazy var backButton = UIButton()
    private let searchTextField = SearchTextField()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(5)
            $0.size.equalTo(48)
        }
        
        self.addSubview(searchTextField)
        searchTextField.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.centerY.equalTo(backButton.snp.centerY)
            $0.leading.equalTo(backButton.snp.trailing)
            $0.trailing.equalToSuperview().inset(24)
        }
    }
    
    private func setUI() {
        
        searchTextField.do {
            $0.configureViewType(viewtype: .search)
            $0.searchToBakeryList = { text in
                self.fetchBakeryList?(text)
            }
        }
        
        backButton.do {
            $0.setImage(.leftArrowIcon, for: .normal)
            $0.addAction(UIAction { [weak self] _ in
                self?.dismissSearchView?()
            }, for: .touchUpInside)
        }
    }
}
