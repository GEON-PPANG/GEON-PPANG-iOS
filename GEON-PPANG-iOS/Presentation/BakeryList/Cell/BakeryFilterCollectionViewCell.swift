//
//  BakeryFilterCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class BakeryFilterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    private var isTapped: Bool = true {
        didSet {
            configureCellUI(isTapped)
        }
    }
    
    // MARK: - UI Property
    
    private let hStackView = UIStackView()
    private let iconView = UIImageView()
    var filterTitle = UILabel()
    
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
        
        contentView.addSubview(hStackView)
        hStackView.addArrangedSubviews(iconView, filterTitle)
        
        hStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        iconView.snp.makeConstraints {
            $0.size.equalTo(20)
        }
    }
    
    private func setUI() {
        
        contentView.do {
            $0.makeCornerRound(radius: 18)
            $0.makeBorder(width: 1, color: .gbbGray200!)
            $0.backgroundColor = .gbbGray100
        }
        hStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
        }
        
        filterTitle.do {
            $0.font = .captionM1
            $0.sizeToFit()
        }
    }
    
    func configureFilterUI(item: BakeryFilterItems, index: Int) {
        
        iconView.image = item.leftIcon
        filterTitle.text = item.filter.title
        isTapped = item.status == .on ? false : true
    }
    
    func configureCellUI(_ isTapped: Bool) {
        
        filterTitle.textColor = isTapped ? .gbbGray700 : .gbbBackground2
        filterTitle.font = .captionM1
        contentView.backgroundColor = isTapped ? .gbbGray100 : .gbbMain3
        contentView.makeBorder(width: 1, color: isTapped ? .gbbGray200! : .gbbMain2!)
    }
    
    func configureFilterSize() {
        
        return filterTitle.sizeToFit()
    }
}
