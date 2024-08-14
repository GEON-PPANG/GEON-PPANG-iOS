//
//  HomeBottomCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import UIKit

import SnapKit

final class HomeBottomCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private let footerLabel: UILabel = {
        let label = UILabel()
        label.font = .captionM2
        label.textColor = .gbbGray300
        label.textAlignment = .left
        label.numberOfLines = 4
        label.setLineHeight(by: 1.37, with: I18N.Home.bottomSectionTitle)
        return label
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
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
}
