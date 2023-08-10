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
    private lazy var noSugarChip = PaddingLabel(padding: padding)
    private let labeling = ["글루텐프리", "비건빵", "넛프리", "저당,무설탕"]
    
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
        
        self.addArrangedSubviews(glutenFreeChip, veganBreadChip, nutFreeChip, noSugarChip)
        
        [glutenFreeChip, veganBreadChip, nutFreeChip, noSugarChip].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(25)
            }
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.axis = .horizontal
            $0.spacing = 4
            $0.distribution = .equalSpacing
        }
        
        [glutenFreeChip, veganBreadChip, nutFreeChip, noSugarChip].enumerated().forEach { index, chip in
            chip.do {
                $0.basic(text: labeling[index], font: .captionM1!, color: .gbbGray400!)
                $0.makeCornerRound(radius: 3)
                $0.makeBorder(width: 0.5, color: .gbbGray300!)
            }
        }
    }
    
    // MARK: - Custom Method
    
    func getChipStatus(_ isGlutenFree: Bool, _ isveganBread: Bool, _ isnutFree: Bool, _ isnoSugarChip: Bool) {
        if !isGlutenFree {
            glutenFreeChip.isHidden = true
        } else {
            glutenFreeChip.isHidden = false
        }
        if !isveganBread {
            veganBreadChip.isHidden = true
        } else {
            veganBreadChip.isHidden = false
        }
        if !isnutFree {
            nutFreeChip.isHidden = true
        } else {
            nutFreeChip.isHidden = false
        }
        if !isnoSugarChip {
            noSugarChip.isHidden = true
        } else {
            noSugarChip.isHidden = false
        }
    }
}
