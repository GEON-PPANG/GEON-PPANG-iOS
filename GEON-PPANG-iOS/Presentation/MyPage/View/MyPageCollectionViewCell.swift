//
//  MyPageCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class MyPageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private let titleLabel = UILabel()
    private let rightChevronImageViewContainer = UIView()
    private let rightChevronImageView = UIImageView(image: .rightArrowIcon)
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        
        contentView.addSubview(rightChevronImageViewContainer)
        rightChevronImageViewContainer.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.width.height.equalTo(48)
            $0.trailing.equalToSuperview().inset(6)
        }
        
        rightChevronImageViewContainer.addSubview(rightChevronImageView)
        rightChevronImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setUI() {
        
        contentView.do {
            $0.backgroundColor = .gbbWhite
        }
        
        titleLabel.do {
            $0.font = .bodyM1
            $0.textColor = .gbbBlack
        }
    }
    
    // MARK: - Custom Method
    
    func configureTitle(to text: String) {
        
        titleLabel.do {
            $0.text = text
        }
    }
    
    func applyTopThickBorder() {
        
        let borderView = UIView()
        contentView.addSubview(borderView)
        borderView.snp.makeConstraints {
            $0.bottom.equalTo(contentView.snp.top)
            $0.height.equalTo(8)
            $0.horizontalEdges.equalToSuperview()
        }
        
        borderView.do {
            $0.backgroundColor = .gbbGray200
        }
    }
    
    func applyTopThinBorder() {
        
        let borderView = UIView()
        contentView.addSubview(borderView)
        borderView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.equalToSuperview()
        }
        
        borderView.do {
            $0.backgroundColor = .gbbGray200
        }
    }
    
}
