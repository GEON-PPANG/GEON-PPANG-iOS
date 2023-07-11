//
//  BakeryListTopView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/11.
//

import UIKit

import SnapKit
import Then

final class BakeryListTopView: UIView {
    
    // MARK: - Property
    
    // MARK: - UI Property
    
    private let hStackView = UIStackView()
    private let bakeryTitle = UILabel()
    private let bakeryIcon = UIImageView()
    private let searchButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        hStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.sizeToFit()
        }
        
        bakeryTitle.do {
            $0.basic(text: I18N.BakeryList.bakeryTitle,
                     font: .pretendardBold(26),
                     color: .gbbGray700!)
        }
        
        bakeryIcon.do {
            $0.image = .listIcon
            $0.contentMode = .scaleAspectFit
        }
        
        searchButton.do {
            $0.setImage(.searchIcon600, for: .normal)
        }
    }
    
    private func setLayout() {
        addSubviews(hStackView, searchButton)
        hStackView.addArrangedSubviews(bakeryTitle, bakeryIcon)
        
        hStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().offset(-15)
            $0.top.equalToSuperview().offset(44)
        }
        
        bakeryIcon.snp.makeConstraints {
            $0.size.equalTo(24)
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(hStackView.snp.top)
            $0.trailing.equalToSuperview().offset(-23)
            $0.bottom.equalToSuperview().offset(-15)
        }
    }
}
