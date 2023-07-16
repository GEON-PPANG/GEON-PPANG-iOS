//
//  ReviewProgressBarStackView.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/16.
//

import UIKit

import SnapKit
import Then

final class ReviewProgressBarStackView: UIStackView {

    // MARK: - UIProperty
    
    private lazy var deliciousProgressView = BakeryDetailReviewProgressView()
    private lazy var specialProgressView = BakeryDetailReviewProgressView()
    private lazy var kindProgressView = BakeryDetailReviewProgressView()
    private lazy var zeroWasteProgressView = BakeryDetailReviewProgressView()
    private let labeling = ["맛있어요", "특별한 메뉴", "친절해요", "제로웨이스트"]
    private var tempGauge: [Float] = [0.8, 0.5, 0.7, 0.6]
    private let tempWidth = [45, 60, 45, 68]
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
        setLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        
        self.do {
            $0.axis = .horizontal
            $0.spacing = 30
            $0.distribution = .equalCentering
        }
        
        [deliciousProgressView, specialProgressView, kindProgressView, zeroWasteProgressView].enumerated().forEach { index, view in
            view.do {
                $0.backgroundColor = .gbbWhite
                $0.reviewLabel.text = labeling[index]
                $0.gauge = tempGauge[index]
            }
        }
    }
    
    private func setLayout() {
        
        self.addArrangedSubviews(deliciousProgressView, specialProgressView, kindProgressView, zeroWasteProgressView)
        
        [deliciousProgressView, specialProgressView, kindProgressView, zeroWasteProgressView].enumerated().forEach { index, view in
            view.snp.makeConstraints {
                $0.width.equalTo(tempWidth[index])
                $0.height.equalTo(134)
            }
        }
    }
}
