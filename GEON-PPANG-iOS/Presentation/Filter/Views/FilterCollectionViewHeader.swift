//
//  FilterCollectionViewHeader.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/08/19.
//

import UIKit

import SnapKit

final class FilterCollectionViewHeader: UICollectionReusableView {
    
    // MARK: - UI Property
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        self.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(44)
            $0.leading.equalToSuperview()
        }
    }
    
    private func setUI() {
        
        titleLabel.do {
            $0.setLineHeight(by: 1.12)
            $0.font = .title1
            $0.textColor = .gbbGray700
            $0.numberOfLines = 2
        }
        
        subtitleLabel.do {
            $0.font = .subHead
            $0.textColor = .gbbGray400
            $0.isHidden = true
        }
    }
    
    // MARK: - Custom Method
    
    func configureTitles(to type: FilterType) {
        
        titleLabel.do {
            $0.text = type.title
        }
        
        subtitleLabel.do {
            $0.text = type.subtitle
            $0.isHidden = type == .purpose ? true : false
        }
    }
    
}
