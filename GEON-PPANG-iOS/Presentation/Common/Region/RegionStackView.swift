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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setUI()
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
    
    // MARK: - Custom Method
    
    func configureStackView(with regions: [String]) {
        regions.forEach { region in
            regionStackView.addArrangedSubview(RegionChip(name: region, isBlack: true))
        }
    }
    
}
