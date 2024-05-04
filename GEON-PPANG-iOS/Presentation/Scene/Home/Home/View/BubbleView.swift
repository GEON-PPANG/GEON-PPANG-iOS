//
//  BubbleView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/08/28.
//

import UIKit

import SnapKit
import Then

final class BubbleView: UIView {

    // MARK: - Property
    
    enum BubbleType {
        case left
        case right
        
        var image: UIImage {
            switch self {
            case .left: return .Image.Bubble.left
            case .right: return .Image.Bubble.right
            }
        }
    }
    
    var bubbleType: BubbleType
    
    // MARK: - UI Property
    
    private let bubbleView = UIImageView()
    private let titleLabel = UILabel()
    private let cancelButton = UIButton()
    
    // MARK: - Life Cycle
    
    init(type: BubbleType) {
        self.bubbleType = type
        
        super.init(frame: .zero)
        
        setLayout()
        setUI()
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
    
    private func setUI() {
        
        bubbleView.do {
            $0.image = bubbleType.image
        }
        
        titleLabel.do {
            $0.basic(text: I18N.Home.bubbleTitle,
                     font: .captionM2!,
                     color: .gbbGray400)
        }
        
        cancelButton.do {
            $0.setImage(.Icon.deleteKeyword, for: .normal)
            $0.addAction(UIAction { _ in
                self.removeFromSuperview()
            }, for: .touchUpInside)
        }
    }
    
    func configureLayout(trailing: ConstraintRelatableTarget,
                         top: ConstraintRelatableTarget,
                         offset: Float) {
        
        self.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 209, height: 36))
            $0.trailing.equalTo(trailing).inset(24)
            $0.top.equalTo(top).offset(offset)
        }
    }
}
