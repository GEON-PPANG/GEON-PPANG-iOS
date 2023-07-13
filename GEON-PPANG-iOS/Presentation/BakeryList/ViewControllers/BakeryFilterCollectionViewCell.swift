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
            updateUI(isTapped)
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
    
    private func setUI() {
        contentView.do {
            $0.makeCornerRound(radius: 18)
            $0.makeBorder(width: 1, color: .gbbGray200!)
            $0.backgroundColor = .gbbGray100
        }
        hStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
            $0.distribution = .fillProportionally
        }
        filterTitle.do {
            $0.font = .pretendardMedium(13)
            $0.sizeToFit()
        }
    }
    
    private func setLayout() {
        contentView.addSubview(hStackView)
        hStackView.addArrangedSubviews(iconView, filterTitle)
        
        hStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12))
        }
        
        iconView.snp.makeConstraints {
            $0.size.equalTo(20)
        }
    }
    
    func bind(item: BakeryFilterItems, index: Int) {
        iconView.image = item.leftIcon
        filterTitle.text = item.filter.title
        isTapped = item.status == .on ? false : true
    }
    
    func updateUI(_ isTapped: Bool) {
        filterTitle.textColor = isTapped ? .black : .gbbBackground2
        contentView.backgroundColor = isTapped ? .gbbGray100 : .gbbMain3
        contentView.makeBorder(width: 1, color: isTapped ? .gbbGray200! : .gbbMain2!)
    }
    
    func getSize() {
        return filterTitle.sizeToFit()
    }
}
