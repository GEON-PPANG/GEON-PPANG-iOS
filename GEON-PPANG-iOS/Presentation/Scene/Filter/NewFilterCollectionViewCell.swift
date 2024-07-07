//
//  NewFilterCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 7/7/24.
//

import UIKit

import SnapKit

final class NewFilterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - ui properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .title2
        label.textColor = .gbbGray300
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .subHead
        label.textColor = .gbbGray300
        return label
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup
    
    private func setUI() {
        contentView.backgroundColor = .gbbBackground2
        contentView.makeBorder(width: 1, color: .gbbGray300)
        contentView.makeCornerRound(radius: 10)
    }
    
    private func setLayout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(25)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(25)
        }
    }
}

extension NewFilterCollectionViewCell {
    func configureContent(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
