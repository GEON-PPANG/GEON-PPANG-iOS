//
//  BakeryListTopView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class BakeryListTopView: UIView {
    
    // MARK: - UI Property
    
    private let bakeryTitle = UILabel()
    private let searchButton = UIButton()
    
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
        
        self.addSubview(bakeryTitle)
        bakeryTitle.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        self.addSubview(searchButton)
        searchButton.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.centerY.equalTo(bakeryTitle.snp.centerY)
            $0.trailing.equalToSuperview().inset(23)
        }
    }
    
    private func setUI() {
        
        bakeryTitle.do {
            $0.basic(text: I18N.BakeryList.bakeryTitle,
                     font: .title1!,
                     color: .gbbGray700)
        }
        
        searchButton.do {
            $0.setImage(.Icon.Search.gray400, for: .normal)
        }
    }
    
    func addActionToSearchButton(_ action: @escaping () -> Void) {
        
        searchButton.addAction(UIAction { _ in
            action()
        }, for: .touchUpInside)
    }
}
