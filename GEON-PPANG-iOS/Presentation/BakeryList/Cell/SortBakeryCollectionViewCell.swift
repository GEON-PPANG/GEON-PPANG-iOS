//
//  SortBakeryCollectionViewcell.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class SortBakeryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    override var isSelected: Bool {
        didSet {
            toggleUI()
        }
    }
    
    var sortBy: SortBakery = .byDefault
    
    // MARK: - UI Property
    
    private let sortByLabel = UILabel()
    private let checkImageView = UIImageView(image: .checkIcon)
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        addSubview(sortByLabel)
        sortByLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        addSubview(checkImageView)
        checkImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(sortByLabel)
            $0.size.equalTo(24)
        }
    }
    
    private func setUI() {
        sortByLabel.do {
            $0.textColor = .gbbGray400
            $0.font = .bodyM1
        }
        
        checkImageView.do {
            $0.isHidden = true
        }
    }
    
    // MARK: - Custom Method
    
    func configureLabel(to text: String) {
        sortByLabel.do {
            $0.text = text
        }
    }
    
    func configureSelected() {
        sortByLabel.do {
            $0.textColor = .gbbMain3
            $0.font = .bodyB1
        }
        
        checkImageView.do {
            $0.isHidden = false
        }
    }
    
    private func toggleUI() {
        sortByLabel.do {
            $0.textColor = isSelected ? .gbbMain3 : .gbbGray400
            $0.font = isSelected ? .bodyB1 : .bodyM1
        }
        
        checkImageView.do {
            $0.isHidden = !isSelected
        }
    }
    
}
