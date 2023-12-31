//
//  HomeBottomCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import UIKit

import SnapKit
import Then

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
    
    private func setLayout() {
        
        contentView.addSubview(footerLabel)
        footerLabel.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
        }
    }
    
    private func setUI() {

        footerLabel.do {
            $0.textAlignment = .left
            $0.numberOfLines = 4
            $0.basic(font: .captionM2!,
                     color: .gbbGray300!)
            $0.setLineHeight(by: 1.37, with: I18N.Home.bottomSectionTitle)
        }
    }
}
