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
    
    // TODO: filterPurposeType 으로 변경
    let purposeType = "맛 • 다이어트"
    
    // MARK: - UI Property
    
    private let purposeLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
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
            // TODO: filterPurposeType 으로 변환 후 .rawValue 사용
            $0.text = purposeType
            $0.font = .captionM1
            $0.textColor = .gbbPoint1
        }
    }
    
}
