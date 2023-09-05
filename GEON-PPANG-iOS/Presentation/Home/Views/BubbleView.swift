//
//  BubbleView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/08/28.
//

import UIKit

import SnapKit
import Then

enum BubbleType {
    case home
    case list
}

final class BubbleView: UIView {
    
    // MARK: - Property
    
    var tappedCancelButton: (() -> Void)?
    
    // MARK: - UI Property
    
    private let bubbleView = UIImageView()
    private let titleLabel = UILabel()
    private let cancelButton = UIButton()
    
    // MARK: - Life Cycle
    
    init(_ type: BubbleType) {
        super.init(frame: .zero)
        
        setLayout()
        setUI(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.addSubview(bubbleView)
        bubbleView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview().offset(3)
        }
        
        self.addSubview(cancelButton)
        cancelButton.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.size.equalTo(16)
        }
    }
    
    private func setUI(type: BubbleType) {
        
        bubbleView.do {
            $0.image = type == .home ? .leftBubbleImage : .rightBubbleImage
        }
        
        titleLabel.do {
            $0.basic(text: I18N.Home.bubbleTitle,
                     font: .captionM2!,
                     color: .gbbGray400!)
        }
        
        cancelButton.do {
            $0.setImage(.deleteKeywordIcon, for: .normal)
            $0.addAction(UIAction { _ in
                self.tappedCancelButton?()
            }, for: .touchUpInside)
        }
    }
}
