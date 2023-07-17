//
//  BakeryOverviewView.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/06.
//

import UIKit

import SnapKit
import Then

final class BakeryOverviewView: UIView {
    
    // MARK: - UI Property
    
    private let bakeryImageView = UIImageView()
    private let sampleView = UIView()
    private let regionStackView = RegionStackView()
    
    // MARK: - Life Cycle
    
    init(bakeryImage: UIImage, firstRegion: String, secondRegion: String) {
        super.init(frame: .zero)
        
        setProperties(bakeryImage, firstRegion, secondRegion)
        setLayout()
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setProperties(_ bakeryImage: UIImage, _ firstRegion: String, _ secondRegion: String) {
        self.bakeryImageView.image = bakeryImage
        if secondRegion == "" {
            regionStackView.removeSecondRegion()
        }
        regionStackView.getRegionName(firstRegion, secondRegion)
        regionStackView.getBackgroundColor(.black)
    }
    
    private func setLayout() {
        addSubview(bakeryImageView)
        bakeryImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview().offset(6)
            $0.width.height.equalTo(84)
        }
        
        addSubview(sampleView)
        sampleView.snp.makeConstraints {
            $0.leading.equalTo(bakeryImageView.snp.trailing).offset(20)
            $0.top.equalToSuperview().inset(24)
            $0.height.width.equalTo(43)
        }
        
        addSubview(regionStackView)
        regionStackView.snp.makeConstraints {
            $0.leading.equalTo(bakeryImageView.snp.trailing).offset(20)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
    
    private func setUI() {
        bakeryImageView.do {
            $0.backgroundColor = .gbbPoint1
            $0.makeCornerRound(radius: 5)
            $0.contentMode = .scaleAspectFill
        }
        
        sampleView.do {
            $0.backgroundColor = .gbbPoint1
        }
    }
    
}
