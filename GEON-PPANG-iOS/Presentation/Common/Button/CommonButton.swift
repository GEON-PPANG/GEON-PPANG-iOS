//
//  CommonButton.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/06.
//

import UIKit

import SnapKit
import Then

enum ButtonTitle: String, CaseIterable {
    
    case login = "로그인"
    case signIn = "회원가입"
    case next = "다음"
    case confirm = "확인"
    case duplicate = "중복 확인"
    case write = "작성하기"
    case start = "시작하기"
    
}

final class CommonButton: UIButton {
    
    // MARK: - Property
    // MARK: = UI Property
    
    init() {
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        makeCornerRound(radius: 11)
        titleLabel?.font = .pretendardMedium(18)
    }
    
    func setButtonTitle(_ title: ButtonTitle) {
        setTitle(title.rawValue, for: .normal)
    }
    
    func setButtonUI(_ color: UIColor,_ border: UIColor? = .clear) {
        self.backgroundColor = color
        
        switch color {
        case .gbbMain3!, .gbbGray700!: setTitleColor(.gbbGray100, for: .normal)
        case .gbbMain2!: setTitleColor(.white, for: .normal)
        default:
            setTitleColor(.gbbGray400, for: .normal)
        }
        
        if let border = border {
            makeBorder(width: 1, color: border)
            if border != .clear {
                setTitleColor(border, for: .normal)
            }
        }
    }
    
    func setAction(completion: ((UIAction) -> Void)? = nil) {
        let action = UIAction { action in
            completion?(action)
        }
        addAction(action, for: .touchUpInside)
    }
}
