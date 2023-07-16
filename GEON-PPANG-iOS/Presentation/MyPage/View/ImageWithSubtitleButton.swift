//
//  ImageWithSubtitleButton.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/14.
//

import UIKit

import SnapKit
import Then

final class ImageWithSubtitleButton: UIButton {
    
    // MARK: - Property
    
    enum ButtonType {
        case bookmark
        case myReview
    }
    
    private var buttonImage: UIImage {
        switch type {
        case .bookmark: return .bookmarkIcon
        case .myReview: return .reviewIcon
        }
    }
    
    private var buttonSubtitle: String {
        switch type {
        case .bookmark: return I18N.MyPage.bookmark
        case .myReview: return I18N.MyPage.myReviews
        }
    }
    
    private var type: ButtonType
    
    // MARK: - UI Property
    
    private lazy var buttonImageView = UIImageView(image: buttonImage)
    private lazy var buttonSubtitleLabel = UILabel()
    
    // MARK: - Life Cycle
    
    init(buttonType: ButtonType) {
        self.type = buttonType
        
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
        self.snp.makeConstraints {
            $0.width.equalTo(66)
            $0.height.equalTo(45)
        }
        
        addSubview(buttonImageView)
        buttonImageView.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        addSubview(buttonSubtitleLabel)
        buttonSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(buttonImageView.snp.bottom).offset(4)
            $0.centerX.equalTo(buttonImageView)
        }
    }
    
    private func setUI() {
        buttonSubtitleLabel.do {
            $0.text = buttonSubtitle
            $0.font = .captionB1
            $0.textColor = .gbbPoint1
        }
    }
    
    // MARK: - Custom Method
    
    func addButtonAction(_ tapped: @escaping () -> Void) {
        let action = UIAction { _ in
            tapped()
        }
        self.addAction(action, for: .touchUpInside)
    }
    
}
