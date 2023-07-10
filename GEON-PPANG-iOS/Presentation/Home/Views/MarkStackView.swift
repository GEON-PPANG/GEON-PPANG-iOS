//
//  MarkStackView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class MarkStackView: UIStackView {
    
    private let hccpMarkIconView = UIImageView()
    private let veganIconView = UIImageView()
    private let gmoIconView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.do {
            $0.addArrangedSubviews(hccpMarkIconView, veganIconView, gmoIconView)
            $0.spacing = -9
            $0.axis = .horizontal
        }
        hccpMarkIconView.do {
            $0.image = .bigHACCPMark
            $0.contentMode = .scaleAspectFit
        }
        veganIconView.do {
            $0.image = .bigVeganMark
            $0.contentMode = .topLeft
        }
        gmoIconView.do {
            $0.image = .bigGMOMark
            $0.contentMode = .topLeft
        }
    }
    
    private func setLayout() {
        [hccpMarkIconView, veganIconView, gmoIconView].forEach {
            $0.snp.makeConstraints {
                $0.size.equalTo(28)
            }
        }
    }
    
    func getMarkStatus(_ isHACCP: Bool, _ isVegan: Bool, _ isNONGMO: Bool) {
        if !isHACCP {
            hccpMarkIconView.isHidden = true
        } else if !isVegan {
            veganIconView.isHidden = true
        } else if !isNONGMO {
            gmoIconView.isHidden = true
        }
    }
}
