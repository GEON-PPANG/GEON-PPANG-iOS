//
//  RegionChip.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/06.
//

import UIKit

import SnapKit
import Then

final class RegionChip: UIView {
    
    // MARK: - Property
    
    private let regionName: String
    private let isBlack: Bool
    
    // MARK: - UI Property
    
    private let regionNameLabel = UILabel()
    
    // MARK: - Life Cycle
    
    init(name: String, isBlack: Bool) {
        self.regionName = name
        self.isBlack = isBlack
        
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
        addSubview(regionNameLabel)
        regionNameLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(6)
            $0.verticalEdges.equalToSuperview().inset(8)
        }
    }
    
    private func setUI() {
        self.do {
            $0.backgroundColor = isBlack ? .black : .gbbMain3
            $0.makeCornerRound(radius: 15)
        }
        
        regionNameLabel.do {
            $0.text = regionName
            $0.font = .captionM1
            $0.textColor = isBlack ? .gbbGray200 : .gbbGray100
        }
    }
    
}
