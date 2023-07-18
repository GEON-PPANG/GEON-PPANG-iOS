//
//  MyPagePurposeChipView.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class MyPagePurposeChipView: UIView {
    
    // MARK: - Property
    
    let purposeType: FilterPurposeType
    
    // MARK: - UI Property
    
    private let purposeLabel = UILabel()
    
    // MARK: - Life Cycle
    
    init(type: FilterPurposeType) {
        self.purposeType = type
        super.init()
        
        setLayout()
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        addSubview(purposeLabel)
        purposeLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(11)
            $0.verticalEdges.equalToSuperview().inset(4)
        }
    }
    
    private func setUI() {
        self.do {
            $0.backgroundColor = .gbbPoint2
            $0.makeCornerRound(radius: 12.5)
            $0.makeBorder(width: 0.5, color: .gbbPoint1!)
        }
        
        purposeLabel.do {
            $0.text = purposeType.rawValue
            $0.font = .captionM1
            $0.textColor = .gbbPoint1
        }
    }
    
}
