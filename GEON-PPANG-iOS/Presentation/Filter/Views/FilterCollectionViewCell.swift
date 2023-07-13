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
    
    enum FilterType {
        case purpose
        case breadType
        case ingredient
    }
    
    var cellSize: CGSize {
        switch filterType {
        case .purpose, .ingredient:
            return .init(width: CGFloat().convertByWidthRatio(327),
                         height: CGFloat().convertByHeightRatio(106))
        case .breadType:
            return .init(width: CGFloat().convertByWidthRatio(153),
                         height: CGFloat().convertByHeightRatio(161))
        }
    }
    
    private var labelSpacing: CGFloat {
        switch filterType {
        case .purpose: return 9
        case .breadType: return 24
        case .ingredient: return 0
        }
    }
    
    override var isSelected: Bool {
        didSet {
            toggleSelection()
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
        switch filterType {
        case .purpose, .ingredient:
            labelStackView.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        case .breadType:
            labelStackView.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().inset(46)
            }
        }
    }
    
    private func configureUI() {
        self.do {
            $0.backgroundColor = .gbbBackground2
            $0.makeBorder(width: 1, color: .gbbGray300!)
            $0.makeCornerRound(radius: 10)
        }
        
        typeLabel.do {
            $0.font = .title2
            $0.textColor = .gbbGray300
        }
        
        descriptionLabel.do {
            $0.font = .bodyM1
            $0.textColor = .gbbGray300
        }
        
        labelStackView.do {
            $0.axis = .vertical
            $0.spacing = labelSpacing
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
    
    private func toggleSelection() {
        UIView.animate(withDuration: 0.2) {
            self.do {
                $0.makeBorder(width: self.isSelected ? 2 : 1, color: self.isSelected ? .gbbMain1! : .gbbGray300!)
            }
        }
        
        UIView.transition(with: typeLabel, duration: 0.2, options: .transitionCrossDissolve) {
            self.typeLabel.do {
                $0.textColor = self.isSelected ? .gbbMain1 : .gbbGray300
            }
        }
        
        UIView.transition(with: descriptionLabel, duration: 0.2, options: .transitionCrossDissolve) {
            self.descriptionLabel.do {
                $0.textColor = self.isSelected ? .gbbMain1 : .gbbGray300
            }
        }
    }
    
}
