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
    
    private let label = UILabel()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        
        self.do {
            $0.backgroundColor = .gbbGray100
            $0.makeCornerRound(radius: 12)
        }
        
        label.do {
            $0.basic(text: "가게 상세정보 및 메뉴는 업체에서 제공된 정보를 기반으로 합니다.\n건빵집 방문 시 한번 더 확인하시기를 추천드립니다.", font: .captionM2!, color: .gbbGray400!)
            $0.adjustsFontSizeToFitWidth = true
            $0.numberOfLines = 2
        }
    }
    
    private func setLayout() {
        
        label.snp.makeConstraints {
            $0.directionalVerticalEdges.equalToSuperview().inset(18)
            $0.directionalHorizontalEdges.equalToSuperview().inset(21)
        }
    }
}
