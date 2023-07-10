//
//  HomeBottomCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import UIKit

final class HomeBottomCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private let footerLabel = UILabel()
    
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
            $0.backgroundColor = .gbbGray100
        }
        
        // TODO: - markdown으로 변경
        
        footerLabel.do {
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.basic(text: I18N.Home.bottomSectionTitle,
                     font: .pretendardMedium(11),
                     color: .gbbGray300!)
            
        }
    }
    
    private func setLayout() {
        contentView.addSubview(footerLabel)
        
        footerLabel.snp.makeConstraints {
            $0.directionalVerticalEdges.equalToSuperview().inset(20)
            $0.directionalHorizontalEdges.equalToSuperview().inset(30)
        }
    }
}