//
//  DescriptionCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/05.
//

import UIKit

import SnapKit
import Then

final class DescriptionCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private let descriptionLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setStyle()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(5)
            $0.verticalEdges.equalToSuperview().inset(1)
        }
    }
    
    private func setStyle() {
        self.do {
            // TODO: asset 추가 시 변경
            $0.makeBorder(width: 0.5, color: .systemGray)
            $0.makeCornerRound(radius: 3)
        }
        
        descriptionLabel.do {
            $0.font = .pretendardMedium(13)
            // TODO: asset 추가 시 변경
            $0.textColor = .systemGray
        }
    }
    
    // MARK: - Custom Method
    
    func configureTag(_ text: String) {
        descriptionLabel.text = text
    }
    
}
