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
    case memo
    
    var icon: UIImage? {
        switch self {
        case .smile: return .smileEmoji
        case .sad: return .sadEmoji
        case .memo: return .memoEmoji
            
        }
    }
}

final class CommonBottomSheet: UIView {
    
    // MARK: - Property
    
    private var emojiType: EmojiType = .smile
    var dismissClosure: (() -> Void)?
    
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
    
    private func setLayout() {
        addSubviews(emojiIcon, bottonSheetTitle, confirmButton)
        
        emojiIcon.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.top.equalToSuperview().offset(34)
            $0.centerX.equalToSuperview()
        }
        
        bottonSheetTitle.snp.makeConstraints {
            $0.top.equalTo(emojiIcon.snp.bottom).offset(23)
            $0.centerX.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(bottonSheetTitle.snp.bottom).offset(30)
            $0.directionalHorizontalEdges.equalToSuperview().inset(25)
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
            $0.getButtonUI(.gbbGray700!)
            $0.getButtonTitle(.confirm)
            $0.addAction {
                self.dismissClosure?()
            }
        }
    }
    
    func getEmojiType(_ type: EmojiType) {
        emojiIcon.image = type.icon
    }
    
    func getBottonSheetTitle(_ title: String) {
        bottonSheetTitle.text = title
    }
}