//
//  BakeryDetailCollectionViewFooter.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/19.
//

import UIKit

import SnapKit
import Then

final class BakeryDetailCollectionViewFooter: UICollectionReusableView {
    
    // MARK: - UIProperty
    
    private let labelContainer = UIView()
    private let label = UILabel()
    private let underLineView = LineView()
    
    // MARK: - Initializer
    
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
        
        self.addSubview(labelContainer)
        labelContainer.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(28.5)
        }
        
        labelContainer.addSubview((label))
        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(20)
            $0.directionalHorizontalEdges.equalToSuperview().inset(21)
            $0.width.equalTo(285)
            $0.height.equalTo(36)
        }
        
        self.addSubview(underLineView)
        underLineView.snp.makeConstraints {
            $0.top.equalTo(labelContainer.snp.bottom).offset(27.5)
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.backgroundColor = .gbbWhite
        }
        
        labelContainer.do {
            $0.backgroundColor = .gbbGray100
            $0.makeCornerRound(radius: 12)
        }
        
        label.do {
            $0.setLineHeight(by: 1.35)
            $0.basic(text: I18N.Detail.menuNotice, font: .captionM2!, color: .gbbGray400)
            $0.adjustsFontSizeToFitWidth = true
            $0.numberOfLines = 2
        }
    }
}
