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
    
    private let emojiImageView = UIImageView(image: .memoEmoji)
    private let sheetTitleLabel = UILabel()
    private let sheetDescriptionLabel = UILabel()
    
    private let lineView = UIView()
    private lazy var quitButton = UIButton()
    private lazy var continueButton = UIButton()
    private lazy var buttonStackView = UIStackView(arrangedSubviews: [quitButton, continueButton])
    private let buttonSeperator = UIView()
    
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
            $0.height.equalTo(53)
            $0.bottom.equalToSuperview().inset(CGFloat().heightConsideringBottomSafeArea(41))
            $0.horizontalEdges.equalToSuperview()
        }
        
        quitButton.snp.makeConstraints {
            $0.width.equalTo(SizeLiteral.Screen.width / 2)
        }
        
        continueButton.snp.makeConstraints {
            $0.width.equalTo(SizeLiteral.Screen.width / 2)
        }
        
        addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(7)
            $0.bottom.equalTo(buttonStackView.snp.top)
            $0.height.equalTo(1)
        }
        
        buttonStackView.addSubview(buttonSeperator)
        buttonSeperator.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(14)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(1)
        }
    }
    
    private func setUI() {
        sheetTitleLabel.do {
            $0.text = I18N.WriteReview.sheetTitle
            $0.font = .title2
            $0.textColor = .gbbGray500
        }
        
        sheetDescriptionLabel.do {
            $0.font = .bodyM2
            $0.textColor = .gbbGray400
            $0.numberOfLines = 2
            $0.setLineHeight(by: 1.14, with: I18N.WriteReview.sheetDescription)
            $0.textAlignment = .center
        }
        
        quitButton.do {
            $0.setTitle(I18N.WriteReview.sheetQuit, for: .normal)
            $0.setTitleColor(.gbbGray400, for: .normal)
            $0.titleLabel?.font = .bodyM2
            $0.addAction(UIAction { [weak self] _ in
                self?.dismissClosure?()
            }, for: .touchUpInside)
        }
        
        continueButton.do {
            $0.setTitle(I18N.WriteReview.sheetContinue, for: .normal)
            $0.setTitleColor(.gbbGray700, for: .normal)
            $0.titleLabel?.font = .bodyM2
            $0.addAction(UIAction { [weak self] _ in
                self?.continueClosure?()
            }, for: .touchUpInside)
        }
        
        buttonStackView.do {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
        }
        
        lineView.do {
            $0.backgroundColor = .gbbGray200
        }
        
        buttonSeperator.do {
            $0.backgroundColor = .gbbGray200
        }
    }
    
}
