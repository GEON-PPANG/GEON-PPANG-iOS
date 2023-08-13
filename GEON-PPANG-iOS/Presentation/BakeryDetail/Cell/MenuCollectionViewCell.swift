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
    
    private let bakeryMenuLabel = UILabel()
    private let menuPriceLabel = UILabel()
    private let emptyView = UIView()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        contentView.addSubview(bakeryMenuLabel)
        bakeryMenuLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
            $0.width.equalTo(223)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(menuPriceLabel)
        menuPriceLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(80)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(emptyView)
        emptyView.snp.makeConstraints {
            $0.top.equalTo(bakeryMenuLabel.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(12)
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.backgroundColor = .gbbWhite
        }
        
        bakeryMenuLabel.do {
            $0.basic(font: .subHead!, color: .gbbGray500!)
        }
        
        menuPriceLabel.do {
            $0.basic(font: .subHead!, color: .gbbGray400!)
            $0.textAlignment = .right
        }
    }
    
    // MARK: - Custom Method
    
    func configureCellUI(_ data: MenuList) {
        
        bakeryMenuLabel.text = data.menuName
        menuPriceLabel.text = data.menuPrice.priceText
    }
}
