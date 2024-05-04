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
    
    var dismissClosure: (() -> Void)?
    var continueClosure: (() -> Void)?
    
    // MARK: - UI Property
    
    private let emojiImageView = UIImageView(image: .Icon.Review.bread)
    private let sheetTitleLabel = UILabel()
    private let sheetDescriptionLabel = UILabel()
    
    private let quitButton = CommonButton()
    private let continueButton = CommonButton()
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
        
        self.addSubview(emojiImageView)
        emojiImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(sheetTitleLabel)
        sheetTitleLabel.snp.makeConstraints {
            $0.top.equalTo(emojiImageView.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(sheetDescriptionLabel)
        sheetDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(sheetTitleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(CGFloat().heightConsideringBottomSafeArea(58))
            $0.centerX.equalToSuperview()
        }
        
        quitButton.snp.makeConstraints {
            $0.width.equalTo(157)
            $0.verticalEdges.equalToSuperview()
        }
        
        continueButton.snp.makeConstraints {
            $0.width.equalTo(157)
            $0.verticalEdges.equalToSuperview()
        }
    }
    
    private func setUI() {
        
        sheetTitleLabel.do {
            $0.text = I18N.Review.sheetTitle
            $0.font = .title2
            $0.textColor = .gbbGray500
        }
        
        sheetDescriptionLabel.do {
            $0.font = .bodyM2
            $0.textColor = .gbbGray400
            $0.numberOfLines = 2
            $0.setLineHeight(by: 1.14, with: I18N.Review.sheetDescription)
            $0.textAlignment = .center
        }
        
        quitButton.do {
            $0.configureButtonUI(.gbbGray100)
            $0.configureButtonTitle(to: I18N.Review.sheetQuit)
            $0.configureButtonTitle(color: .gbbGray300)
            $0.tappedCommonButton = {
                self.dismissClosure!()
            }
        }
        
        continueButton.do {
            $0.configureButtonUI(.gbbBlack)
            $0.configureButtonTitle(to: I18N.Review.sheetContinue)
            $0.configureButtonTitle(color: .gbbGray100)
            $0.tappedCommonButton = {
                self.continueClosure!()
            }
        }
        
        buttonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 12
        }
    }
    
}
