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
    
    // MARK: - UI Property
    
    private let hStackView = UIStackView()
    private let bakeryTitle = UILabel()
    private let bakeryIcon = UIImageView()
    private let searchButton = UIButton()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        hStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.sizeToFit()
        }
        
        bakeryTitle.do {
            $0.basic(text: I18N.BakeryList.bakeryTitle,
                     font: .title1!,
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
            $0.top.equalToSuperview().offset(44)
            $0.leading.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().inset(15)
        }
        
        bakeryIcon.snp.makeConstraints {
            $0.size.equalTo(24)
        }
        
        searchButton.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.centerY.equalTo(hStackView.snp.centerY)
            $0.trailing.equalToSuperview().inset(23)
        }
    }
    
    func addActionToSearchButton(_ action: @escaping () -> Void) {
        searchButton.addAction(UIAction { _ in
            action()
        }, for: .touchUpInside)
    }
}
