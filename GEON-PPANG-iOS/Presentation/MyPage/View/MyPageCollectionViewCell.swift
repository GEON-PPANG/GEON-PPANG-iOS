//
//  MyPageCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class MyPageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private let titleLabel = UILabel()
    
    // MARK: - Life Cycle
    
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
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setUI() {
        
        contentView.do {
            $0.backgroundColor = .gbbWhite
        }
        
        titleLabel.do {
            $0.font = .bodyM1
            $0.textColor = .gbbBlack
        }
    }
    
    // MARK: - Custom Method
    
    func configureTitle(to text: String) {
        
        titleLabel.do {
            $0.text = text
        }
    }
    
}
