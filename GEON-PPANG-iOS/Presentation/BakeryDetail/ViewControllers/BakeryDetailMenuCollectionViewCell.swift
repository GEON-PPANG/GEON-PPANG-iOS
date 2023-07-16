//
//  BakeryDetailMenuCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class BakeryDetailMenuCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private let bakeryMenuLabel = UILabel()
    private let menuPriceLabel = UILabel()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        
        bakeryMenuLabel.do {
            $0.basic(text: "요거요거요거바라 블루베리 케이크", font: .subHead!, color: .gbbGray500!)
            $0.numberOfLines = 1
        }
        
        menuPriceLabel.do {
            $0.basic(text: "32,500원", font: .subHead!, color: .gbbGray400!)
        }
    }
    
    private func setLayout() {
        
        bakeryMenuLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(104)
        }
        
        menuPriceLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.equalToSuperview().inset(247)
        }
    }
}
