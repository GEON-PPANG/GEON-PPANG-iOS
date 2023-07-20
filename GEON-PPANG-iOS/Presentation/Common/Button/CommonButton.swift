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
    case duplicate = "중복확인"
    case write = "작성하기"
    case start = "시작하기"
    
}

final class CommonButton: UIButton {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        self.do {
            $0.makeCornerRound(radius: 12)
            $0.titleLabel?.font = .headLine
        }
    }
    
    func getButtonTitle(_ title: ButtonTitle) {
        setTitle(title.rawValue, for: .normal)
    }
    
    func getButtonUI(_ color: UIColor, _ border: UIColor? = .clear) {
        self.backgroundColor = color
        switch color {
        case .gbbMain2!, .gbbGray700!: setTitleColor(.gbbGray100, for: .normal)
        default:
            setTitleColor(.gbbGray400, for: .normal)
        }
        
        if border != .clear {
            makeBorder(width: 1, color: border!)
            setTitleColor(border!, for: .normal)
        }
    }
    
    func updateUI(_ isTrue: @escaping () -> Void, _ isFalse: @escaping () -> Void) {
        let action = UIAction { [weak self] _ in
            self?.isSelected.toggle()
            if let isSelected = self?.isSelected {
                if isSelected {
                    isTrue()
                } else {
                    isFalse()
                }
            }
        }
        addAction(action, for: .touchUpInside)
    }
    
    func addAction(completion: @escaping () -> Void) {
        let action = UIAction { _ in
            completion()
        }
        addAction(action, for: .touchUpInside)
    }
}
