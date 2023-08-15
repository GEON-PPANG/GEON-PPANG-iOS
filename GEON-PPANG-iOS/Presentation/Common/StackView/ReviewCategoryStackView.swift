//
//  ReviewCategoryStackView.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/18.
//

import UIKit

import SnapKit
import Then

final class ReviewCategoryStackView: UIStackView {

    // MARK: - Property
    
    private var padding = UIEdgeInsets(top: 4, left: 5, bottom: 4, right: 5)
    
    // MARK: - UI Property
    
    private lazy var deliciousChip = PaddingLabel(padding: padding)
    private lazy var specialChip = PaddingLabel(padding: padding)
    private lazy var kindChip = PaddingLabel(padding: padding)
    private lazy var zerowasteChip = PaddingLabel(padding: padding)
    private let labeling = ["맛있어요", "특별한 메뉴", "친절해요", "제로웨이스트"]
    
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
        
        self.addArrangedSubviews(deliciousChip, specialChip, kindChip, zerowasteChip)
        
        [deliciousChip, specialChip, kindChip, zerowasteChip].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(25)
            }
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.axis = .horizontal
            $0.spacing = 5
            $0.distribution = .equalSpacing
        }
        
        [deliciousChip, specialChip, kindChip, zerowasteChip].enumerated().forEach { index, chip in
            chip.do {
                $0.backgroundColor = .gbbPoint2
                $0.basic(text: labeling[index], font: .captionM1!, color: .gbbPoint1!)
                $0.makeCornerRound(radius: 3)
            }
        }
    }
    
    // MARK: - Custom Method
    
    func getChipStatus(_ recommendKeywordList: [Int]) {
        
        if !recommendKeywordList.contains(1) {
            deliciousChip.isHidden = true
        } else {
            deliciousChip.isHidden = false
        }
        if !recommendKeywordList.contains(2) {
            specialChip.isHidden = true
        } else {
            specialChip.isHidden = false
        }
        if !recommendKeywordList.contains(3) {
            kindChip.isHidden = true
        } else {
            kindChip.isHidden = false
        }
        if !recommendKeywordList.contains(4) {
            zerowasteChip.isHidden = true
        } else {
            zerowasteChip.isHidden = false
        }
    }
}
