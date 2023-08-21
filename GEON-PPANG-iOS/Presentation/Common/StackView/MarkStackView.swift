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
    
    // MARK: - UI Property
    
    private lazy var hccpMarkIconView = UIImageView()
    private lazy var veganIconView = UIImageView()
    private lazy var gmoIconView = UIImageView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        [hccpMarkIconView, veganIconView, gmoIconView].forEach {
            $0.snp.makeConstraints {
                $0.size.equalTo(24)
            }
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.addArrangedSubviews(hccpMarkIconView, veganIconView, gmoIconView)
            $0.spacing = -8
            $0.axis = .horizontal
        }
        
        hccpMarkIconView.do {
            $0.contentMode = .topLeft
        }
        
        veganIconView.do {
            $0.contentMode = .topLeft
        }
        
        gmoIconView.do {
            $0.contentMode = .topLeft
        }
    }
    
    func confiureIconImage(_ haccp: UIImage, _ vegan: UIImage, _ gmo: UIImage) {
        
        hccpMarkIconView.image = haccp
        veganIconView.image = vegan
        gmoIconView.image = gmo
    }
    
    func getMarkStatus(_ isHACCP: Bool, _ isVegan: Bool, _ isNONGMO: Bool) {
        
        if !isHACCP {
            hccpMarkIconView.isHidden = true
        } else {
            hccpMarkIconView.isHidden = false
        }
        if !isVegan {
            veganIconView.isHidden = true
        } else {
            veganIconView.isHidden = false
        }
        if !isNONGMO {
            gmoIconView.isHidden = true
        } else {
            gmoIconView.isHidden = false
        }
    }
    
    func configureMarkSize(_ size: Int) {
        
        [hccpMarkIconView, veganIconView, gmoIconView].forEach {
            $0.snp.remakeConstraints {
                $0.size.equalTo(size)
            }
        }
    }
}
