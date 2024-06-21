//
//  FilterCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class FilterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    override var isSelected: Bool {
        didSet {
            configureSelection()
        }
    }
    
    var filterType: FilterType = .purpose {
        didSet {
            configureLayout()
            configureUI()
        }
    }
    
    var typeLabelText: String = "" {
        willSet {
            configureLabelText(type: newValue)
        }
    }
    
    var descriptionLabelText: String = "" {
        willSet {
            configureLabelText(description: newValue)
        }
    }
    
    // MARK: - UI Property
    
    private let typeLabel = UILabel()
    private let descriptionLabel = UILabel()
    private lazy var labelStackView = UIStackView(arrangedSubviews: [typeLabel, descriptionLabel])
    
    // MARK: - Custom Method
    
    private func configureLayout() {
        
        contentView.addSubview(labelStackView)
        labelStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func configureUI() {
        
        self.do {
            $0.backgroundColor = .gbbBackground2
            $0.makeBorder(width: 1, color: .gbbGray300)
            $0.makeCornerRound(radius: 10)
        }
        
        typeLabel.do {
            $0.font = .title2
            $0.textColor = .gbbGray300
        }
        
        descriptionLabel.do {
            $0.font = filterType.descriptionFont
            $0.textColor = .gbbGray300
            $0.setLineHeight(by: 1.12)
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }
        
        labelStackView.do {
            $0.axis = .vertical
            $0.spacing = filterType.labelSpacing
            $0.alignment = .center
        }
    }
    
    private func configureLabelText(type typeText: String) {
        
        typeLabel.do {
            $0.text = typeText
        }
    }
    
    private func configureLabelText(description descriptionText: String) {
        
        descriptionLabel.do {
            $0.text = descriptionText
        }
    }
    
    func configureSelection() {
        
        UIView.animate(withDuration: 0.2) {
            self.do {
                $0.makeBorder(width: self.isSelected ? 2 : 1, color: self.isSelected ? .gbbMain3 : .gbbGray300)
            }
        }
        
        UIView.transition(with: typeLabel, duration: 0.2, options: .transitionCrossDissolve) {
            self.typeLabel.do {
                $0.textColor = self.isSelected ? .gbbMain3 : .gbbGray300
            }
        }
        
        UIView.transition(with: descriptionLabel, duration: 0.2, options: .transitionCrossDissolve) {
            self.descriptionLabel.do {
                $0.textColor = self.isSelected ? .gbbMain3 : .gbbGray300
            }
        }
    }
    
}
