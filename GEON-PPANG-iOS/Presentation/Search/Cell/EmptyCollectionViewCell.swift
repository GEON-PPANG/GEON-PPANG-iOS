//
//  EmptyCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class EmptyCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    private var emptyType: EmptyType = .initialize {
        didSet {
            setLayout()
        }
    }
    
    // MARK: - UI Property
    
    private let emptyIcon = UIImageView()
    private let emptyLabel = UILabel()
    private let emptyStackView = UIStackView()
    
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
    
    private func setLayout() {
        
        contentView.addSubviews(emptyLabel, emptyIcon)
        
        switch emptyType {
        case .noBookmark, .noReview:
            configureLayout(CGSize(width: 154, height: 132), -20)
        case .noSearch:
            configureLayout(CGSize(width: 154, height: 134), -16)
        default:
            configureLayout(CGSize(width: 154, height: 134), -20)
            emptyLabel.snp.updateConstraints {
                $0.centerY.equalToSuperview().offset(60)
            }
        }
    }
    
    private func configureLayout(_ size: CGSize, _ offset: Float) {
        
        emptyLabel.snp.remakeConstraints {
            $0.center.equalToSuperview()
        }
        
        emptyIcon.snp.remakeConstraints {
            $0.size.equalTo(size)
            $0.bottom.equalTo(emptyLabel.snp.top).offset(offset)
            $0.centerX.equalToSuperview().offset(10)
        }
    }
    
    private func setUI() {
        
        emptyIcon.do {
            $0.contentMode = .scaleAspectFit
        }
        
        emptyLabel.do {
            $0.numberOfLines = 0
            $0.basic(font: .title2!, color: .gbbGray300!)
        }
    }
    
    func configureViewType(_ type: EmptyType) {
        
        emptyType = type
        emptyIcon.image = type.icon
        emptyLabel.setLineHeight(by: 1.05, with: type.rawValue)
        emptyLabel.textAlignment = .center
        
        switch type {
        case .initialize, .noBookmark, .noReview:
            return emptyLabel.basic(text: emptyType.rawValue,
                                    font: .title2!,
                                    color: .gbbGray300!)
        case .noSearch:
            return emptyLabel.partFontChange(targetString: type.subTitle, font: .subHead!)
        }
    }
    
    func configureEmptyText(_ text: String) {
        
        emptyLabel.text = text
    }
}
