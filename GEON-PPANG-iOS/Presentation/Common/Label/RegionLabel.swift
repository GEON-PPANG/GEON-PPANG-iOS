//
//  RegionLabel.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/08/21.
//

import UIKit

import SnapKit
import Then

final class RegionLabel: UILabel {
    
    // MARK: - Property
    
    private let firstRegion: String?
    private let secondRegion: String?
    
    // MARK: - UI Property
    
    private let imageView = UIImageView(image: .mapIcon)
    private let label = UILabel()
    
    // MARK: - Life Cycle
    
    init(_ firstRegion: String? = nil, _ secondRegion: String? = nil) {
        self.firstRegion = firstRegion
        self.secondRegion = secondRegion
        
        super.init(frame: .zero)
        
        setLayout()
        setUI()
        setRegionLabelText()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview()
        }
        
        self.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
            $0.centerY.equalTo(imageView)
            $0.trailing.equalToSuperview()
        }
    }
    
    private func setUI() {
        
        label.do {
            $0.font = .captionM1
            $0.textColor = .gbbGray400
        }
    }
    
    private func setRegionLabelText() {
        
        var text = ""
        if let region = firstRegion {
            text += region
        }
        if let secondRegion = secondRegion {
            text += " ∙ \(secondRegion)"
        }
        
        label.text = text
    }
    
}
