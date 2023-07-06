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
    
    // MARK: - UI Property
    
    private let regionNameLabel = UILabel()
    
    // MARK: - Life Cycle
    
    init(name: String) {
        self.regionName = name
        
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
            $0.horizontalEdges.equalTo(8)
            $0.verticalEdges.equalTo(6)
        }
    }
    
    private func setUI() {
        self.do {
            // TODO: asset 추가 시 변경
            $0.backgroundColor = .green
            $0.makeCornerRound(radius: 20)
        }
        
        regionNameLabel.do {
            $0.text = ""
            $0.font = .captionM1
            // TODO: asset 추가 시 변경
            $0.textColor = .white
        }
    }
    
    // MARK: - Action Helper
    
    
    
    // MARK: - Custom Method
    
    
    
}
