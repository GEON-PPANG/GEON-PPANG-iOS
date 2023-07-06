//
//  RegionStackView.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/06.
//

import UIKit

import SnapKit
import Then

final class RegionStackView: UIView {
    
    // MARK: - UI Property
    
    private let regionStackView = UIStackView()
    
    // MARK: - Life Cycle
    
    init(regions: [String]) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
        setStackView(with: regions)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        addSubview(regionStackView)
        regionStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setUI() {
        regionStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
        }
    }
    
    private func setStackView(with regions: [String]) {
        regions.forEach { region in
            regionStackView.addArrangedSubview(RegionChip(name: region))
        }
    }
    
}
