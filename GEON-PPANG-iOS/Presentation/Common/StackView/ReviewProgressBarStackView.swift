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
    
    // MARK: - UI Property
    
    private let deliciousProgressView = ReviewProgressView()
    private let specialProgressView = ReviewProgressView()
    private lazy var kindProgressView = ReviewProgressView()
    private lazy var zeroWasteProgressView = ReviewProgressView()
    private let labeling = ["맛있어요", "특별한 메뉴", "친절해요", "제로웨이스트"]
    private var tempGauge: [Float] = [0.0, 0.0, 0.0, 0.0] {
        didSet {
            setUI()
        }
    }
    private let tempWidth = [45, 60, 45, 68]
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.addArrangedSubviews(deliciousProgressView, specialProgressView, kindProgressView, zeroWasteProgressView)
        
        [deliciousProgressView, specialProgressView, kindProgressView, zeroWasteProgressView].enumerated().forEach { index, view in
            view.snp.makeConstraints {
                $0.width.equalTo(tempWidth[index])
            }
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.axis = .horizontal
            $0.backgroundColor = .gbbWhite
            $0.spacing = 30
            $0.distribution = .equalSpacing
        }
        
        [deliciousProgressView, specialProgressView, kindProgressView, zeroWasteProgressView].enumerated().forEach { index, view in
            view.do {
                $0.reviewLabel.text = labeling[index]
                $0.gauge = tempGauge[index]
            }
        }
    }
    
    // MARK: - Custom Method
    
    func configureGauge (_ deliciousPercent: Float, _ specialPercent: Float, _ kindPercent: Float, _ zerowastePercent: Float) {
        
        tempGauge[0] = deliciousPercent
        tempGauge[1] = specialPercent
        tempGauge[2] = kindPercent
        tempGauge[3] = zerowastePercent
    }
}
