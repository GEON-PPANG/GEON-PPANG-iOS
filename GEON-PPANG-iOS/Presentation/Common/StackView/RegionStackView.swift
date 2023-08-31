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
    private lazy var regionSecondTag = PaddingLabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI(_ hasSecond: Bool) {
        
        self.do {
            if hasSecond {
                $0.addArrangedSubviews(regionFirstTag, regionSecondTag)
            } else {
                $0.addArrangedSubview(regionFirstTag)
            }
            $0.axis = .horizontal
            $0.spacing = 5
            $0.distribution = .fillProportionally
        }
        
        [regionFirstTag, regionSecondTag].forEach {
            $0.makeCornerRound(radius: 6)
            $0.font = .captionM1
            $0.backgroundColor = .gbbBackground1
            $0.textColor = .gbbGray400
            $0.adjustsFontSizeToFitWidth = true
        }
    }
    
    func configureRegionName(_ first: String, _ second: String) {
        
        regionFirstTag.text = first
        regionSecondTag.text = second
        setUI(!second.isEmpty)
    }
    
    func configureRegion(_ data: NearStationResponseDTO) {
        
        regionFirstTag.text = data.stations[0]
        regionSecondTag.text = data.stations[1]
        setUI(!data.stations[1].isEmpty)
    }
    
    func configureBackgroundColor(_ color: UIColor) {
        
        [regionFirstTag, regionSecondTag] .forEach {
            $0.backgroundColor = color
        }
    }
    
    func removeSecondRegion() {
        
        self.removeArrangedSubview(regionSecondTag)
        regionSecondTag.removeFromSuperview()
    }
}
