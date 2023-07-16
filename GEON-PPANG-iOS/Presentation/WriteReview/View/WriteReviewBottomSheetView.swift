//
//  WriteReviewBottomSheetView.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/16.
//

import UIKit

import SnapKit
import Then

final class WriteReviewBottomSheetView: UIView {
    
    // MARK: - Property
    
    
    
    // MARK: - UI Property
    
    private let emojiImageView = UIImageView(image: .memoEmoji)
    private let sheetTitleLabel = UILabel()
    private let sheetDescriptionLabel = UILabel()
    private lazy var quitButton = UIButton()
    private lazy var continueButton = UIButton()
    private lazy var buttonStackView = UIStackView(arrangedSubviews: [quitButton, continueButton])
    
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
        addSubview(emojiImageView)
        emojiImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(27)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(32)
        }
        
        addSubview(sheetTitleLabel)
        sheetTitleLabel.snp.makeConstraints {
            $0.top.equalTo(emojiImageView.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(sheetDescriptionLabel)
        sheetDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(sheetTitleLabel.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(8)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    private func setUI() {
        sheetTitleLabel.do {
            $0.text = I18N.WriteReview.sheetTitle
            $0.font = .title2
            $0.textColor = .gbbGray500
        }
        
        sheetDescriptionLabel.do {
            $0.text = I18N.WriteReview.sheetDescription
            $0.font = .bodyM2
            $0.textColor = .gbbGray400
        }
        
        quitButton.do {
            $0.titleLabel?.text = I18N.WriteReview.sheetQuit
            $0.titleLabel?.font = .bodyM1
            $0.titleLabel?.textColor = .gbbGray400
        }
        
        continueButton.do {
            $0.titleLabel?.text = I18N.WriteReview.sheetContinue
            $0.titleLabel?.font = .bodyM1
            $0.titleLabel?.textColor = .gbbGray700
        }
        
        buttonStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalCentering
        }
    }
    
    // MARK: - Action Helper
    
    
    
    // MARK: - Custom Method
    
    
    
}
