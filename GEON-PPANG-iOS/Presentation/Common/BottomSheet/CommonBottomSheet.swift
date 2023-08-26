//
//  CommonBottomSheet.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/12.
//

import UIKit

import SnapKit
import Then

enum EmojiType {
    case smile
    case sad
    
    var icon: UIImage? {
        switch self {
        case .smile: return .smileIcon
        case .sad: return .sadIcon
        }
    }
}

final class CommonBottomSheet: UIView {
    
    // MARK: - Property
    
    private var emojiType: EmojiType = .smile
    var dismissBottomSheet: (() -> Void)?
    
    // MARK: - UI Property
    
    private let emojiIcon = UIImageView()
    private let bottonSheetTitle = UILabel()
    private lazy var confirmButton = CommonButton()
    
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
        
        self.addSubview(emojiIcon)
        emojiIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(bottonSheetTitle)
        bottonSheetTitle.snp.makeConstraints {
            $0.top.equalTo(emojiIcon.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(confirmButton)
        confirmButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(CGFloat().heightConsideringBottomSafeArea(54))
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
        
    }
    
    private func setUI() {
        
        emojiIcon.do {
            $0.contentMode = .scaleAspectFit
        }
        bottonSheetTitle.do {
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.basic(font: .pretendardBold(20), color: .gbbGray500!)
        }
        confirmButton.do {
            $0.configureButtonUI(.gbbGray700!)
            $0.configureButtonTitle(.confirm)
            $0.addActionToCommonButton {
                self.dismissBottomSheet?()
            }
        }
    }
    
    func configureEmojiType(_ type: EmojiType) {
        
        emojiIcon.image = type.icon
    }
    
    func configureBottonSheetTitle(_ title: String) {
        
        bottonSheetTitle.text = title
    }
}
