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
    case apply = "적용하기"
    
}

final class CommonButton: UIButton {
    
    // MARK: - Property
    
    var tappedCommonButton: (() -> Void)?
    
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
            $0.addAction(UIAction { [weak self] _ in
                guard let self else { return }
                self.tappedCommonButton?()
            }, for: .touchUpInside)
        }
    }
    
    func configureButtonTitle(_ title: ButtonTitle) {
        
        self.setTitle(title.rawValue, for: .normal)
    }
    
    func configureButtonTitle(to text: String) {
        
        self.setTitle(text, for: .normal)
    }
    
    func configureButtonTitle(color: UIColor) {
        
        self.setTitleColor(color, for: .normal)
    }
    
    func configureButtonUI(_ color: UIColor) {
        
        self.backgroundColor = color
        switch color {
        case .gbbMain2!, .gbbGray700!: setTitleColor(.gbbGray100, for: .normal)
        case .clear:
            self.titleLabel?.font = .bodyB1!
            setTitleColor(.gbbGray400, for: .normal)
        default:
            setTitleColor(.gbbGray400, for: .normal)
        }
    }
    
    func configureBorder(_ width: CGFloat?, _ color: UIColor?) {
        self.makeBorder(width: width ?? 0, color: color ?? .clear)
        
        if color == .gbbMain2 {
            setTitleColor(.gbbMain2, for: .normal)
        }
    }
    
    func toggleUI(_ isTrue: @escaping () -> Void, _ isFalse: @escaping () -> Void) {
        
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
    
    func configureInteraction(to value: Bool) {
        self.isUserInteractionEnabled = value
        self.configureButtonUI(value ? .gbbGray700! : .gbbGray200!)
    }
}
