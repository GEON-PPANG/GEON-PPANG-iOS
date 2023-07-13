//
//  OptionBreadTypeStackView.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/13.
//

import UIKit

import SnapKit
import Then

final class OptionBreadTypeStackView: UIStackView {
    
    // MARK: - UI Property
    
    private lazy var glutenFreeChip = PaddingLabel()
    private lazy var veganBreadChip = PaddingLabel()
    private lazy var nutFreeChip = PaddingLabel()
    private lazy var noSugarChip = PaddingLabel()
    private let naming = ["글루텐프리", "비건빵", "넛프리", "저당,무설탕"]
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        
        self.do {
            $0.addArrangedSubviews(glutenFreeChip, veganBreadChip, nutFreeChip, noSugarChip)
            $0.axis = .horizontal
            $0.spacing = 4
            $0.distribution = .equalSpacing
        }
        
        [glutenFreeChip, veganBreadChip, nutFreeChip, noSugarChip].enumerated().forEach { index, chip in
            chip.do {
                $0.text = naming[index]
                $0.makeCornerRound(radius: 3)
                $0.basic(font: .captionM1!, color: .gbbGray400!)
                $0.backgroundColor = .gbbWhite
                $0.makeBorder(width: 0.5, color: .gbbGray300!)
            }
        }
    }
}
