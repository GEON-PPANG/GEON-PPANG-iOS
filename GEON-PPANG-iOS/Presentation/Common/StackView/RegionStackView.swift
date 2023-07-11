//
//  RegionStackView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class RegionStackView: UIStackView {
    
    // MARK: - UI Property
    
    private lazy var regionFirstTag = PaddingLabel()
    private lazy var regionSeconodTag = PaddingLabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        self.do {
            $0.addArrangedSubviews(regionFirstTag, regionSeconodTag)
            $0.axis = .horizontal
            $0.spacing = 5
            $0.distribution = .fillProportionally
        }
        
        [regionFirstTag, regionSeconodTag] .forEach {
            $0.makeCornerRound(radius: 14.5)
            $0.font = .pretendardMedium(13)
            $0.backgroundColor = .gbbMain3
            $0.textColor = .gbbGray100
        }
    }
    
    func getRegionName(_ first: String, _ second: String) {
        regionFirstTag.text = first
        regionSeconodTag.text = second
    }
    
    func getBackgroundColor(_ color: UIColor) {
        [regionFirstTag, regionSeconodTag] .forEach {
            $0.backgroundColor = color
        }
    }
    
    func removeSecondRegion() {
        self.removeArrangedSubview(regionSeconodTag)
        regionSeconodTag.removeFromSuperview()
    }
}