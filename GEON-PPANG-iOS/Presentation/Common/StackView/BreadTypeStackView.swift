//
//  BreadTypeStackView.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/13.
//

import UIKit

import SnapKit
import Then

final class BreadTypeStackView: UIStackView {
    
    // MARK: - Property
    
    private var padding = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6)
    
    // MARK: - UI Property
    
    private lazy var glutenFreeChip = PaddingLabel(padding: padding)
    private lazy var veganBreadChip = PaddingLabel(padding: padding)
    private lazy var nutFreeChip = PaddingLabel(padding: padding)
    private lazy var subSugarChip = PaddingLabel(padding: padding)
    private let labeling = ["글루텐프리", "비건빵", "넛프리", "대체당"]
    
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
        
        self.addArrangedSubviews(glutenFreeChip, veganBreadChip, nutFreeChip, subSugarChip)
        
        [glutenFreeChip, veganBreadChip, nutFreeChip, subSugarChip].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(25)
            }
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.backgroundColor = .gbbBackground1
            $0.axis = .horizontal
            $0.spacing = 4
            $0.distribution = .equalSpacing
        }
        
        [glutenFreeChip, veganBreadChip, nutFreeChip, subSugarChip].enumerated().forEach { index, chip in
            chip.do {
                $0.basic(text: labeling[index], font: .captionM1, color: .gbbPoint1)
                $0.makeCornerRound(radius: 3)
                $0.makeBorder(width: 0.5, color: .gbbPoint1)
            }
        }
    }
    
    // MARK: - Custom Method
    
    func getChipStatus(_ breadTypeList: [BreadType]) {
        let breadTypeIndex = breadTypeList.map { $0.breadTypeId }
        glutenFreeChip.isHidden = !breadTypeIndex.contains(1)
        veganBreadChip.isHidden = !breadTypeIndex.contains(2)
        nutFreeChip.isHidden = !breadTypeIndex.contains(3)
        subSugarChip.isHidden = !breadTypeIndex.contains(4)
    }
}
