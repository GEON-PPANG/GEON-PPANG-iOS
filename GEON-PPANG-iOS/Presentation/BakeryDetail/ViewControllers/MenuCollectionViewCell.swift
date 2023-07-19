//
//  MenuCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class MenuCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private let bakeryMenuLabel = UILabel() // 서버
    private let menuPriceLabel = UILabel() // 서버
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        
        bakeryMenuLabel.do {
            $0.basic(text: "요거요거요거바라 블루베리 케이크", font: .subHead!, color: .gbbGray500!)
        }
        
        menuPriceLabel.do {
            $0.basic(text: "32,500원", font: .subHead!, color: .gbbGray400!)
            $0.textAlignment = .right
        }
    }
    
    private func setLayout() {
        
        contentView.addSubviews(bakeryMenuLabel, menuPriceLabel)
        
        bakeryMenuLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(223)
            $0.height.equalTo(20)
        }
        
        menuPriceLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(20)
        }
    }
}
