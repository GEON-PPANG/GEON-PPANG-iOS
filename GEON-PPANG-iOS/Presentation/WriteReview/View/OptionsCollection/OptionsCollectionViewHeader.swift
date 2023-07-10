//
//  OptionsCollectionViewHeader.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/07.
//

import UIKit

import SnapKit
import Then

final class OptionsCollectionViewHeader: UICollectionReusableView {
    
    // MARK: - UI Property
    
    private let titleLabel = UILabel()
    
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
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setUI() {
        titleLabel.do {
            $0.font = .bodyB1
            $0.textColor = .gbbGray300
            $0.textAlignment = .left
        }
    }
    
    // MARK: - Custom Method
    
    func configureHeaderTitle(to title: String) {
        titleLabel.do {
            $0.text = title
        }
    }
    
    func configureHeaderColor(to color: UIColor) {
        titleLabel.do {
            $0.textColor = color
        }
    }
    
}
