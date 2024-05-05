//
//  DetailBottomView.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/20.
//

import UIKit

import SnapKit
import Then

final class DetailBottomView: UIView {
    
    // MARK: - Property
    
    var tappedBookmarkButton: (() -> Void)?
    var tappedWriteReviewButton: (() -> Void)?
    var check: Bool = false
    
    // MARK: - UI Property
    
    private lazy var bookmarkButton = UIButton()
    
    private let writeReviewButtonTitle = UILabel()
    private lazy var writeReviewButton = UIButton()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setUI()
        setShadow()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.snp.makeConstraints {
            $0.height.equalTo(CGFloat().heightConsideringBottomSafeArea(126))
        }
        
        self.addSubview(bookmarkButton)
        bookmarkButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(24)
            $0.size.equalTo(44)
        }
        
        self.addSubview(writeReviewButton)
        writeReviewButton.snp.makeConstraints {
            $0.centerY.equalTo(bookmarkButton)
            $0.leading.equalTo(bookmarkButton.snp.trailing).offset(32)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(48)
        }
        
        writeReviewButton.addSubview(writeReviewButtonTitle)
        writeReviewButtonTitle.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setUI() {
        
        bookmarkButton.do {
            $0.setImage(.bookmarkButtonDisable, for: .normal)
            $0.addAction(UIAction { [weak self] _ in
                self?.tappedBookmarkButton?()
            }, for: .touchUpInside)
        }
        
        writeReviewButton.do {
            $0.backgroundColor = .gbbMain2
            $0.makeCornerRound(radius: 10)
            $0.addAction(UIAction { [weak self] _ in
                self?.tappedWriteReviewButton?()
            }, for: .touchUpInside)
        }
        
        writeReviewButtonTitle.do {
            $0.text = I18N.Detail.writeReview
            $0.font = .bodyB2
            $0.textColor = .gbbWhite
        }
    }

    private func setShadow() {
        
        self.layer.applyShadow(color: .init(red: 0, green: 0, blue: 0, alpha: 0.1),
                               alpha: 1,
                               x: 0,
                               y: 1,
                               blur: 10)
    }
    
    // MARK: - Custom Method
    
    func configureBookmarkButton(to isSelected: Bool) {
        
        bookmarkButton.do {
            $0.setImage((isSelected ? UIImage.bookmarkButtonEnable : UIImage.bookmarkButtonDisable), for: .normal)
        }
    }
}
