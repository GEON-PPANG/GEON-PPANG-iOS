//
//  BubbleBuilder.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 6/26/24.
//

import UIKit
import SnapKit

final class BubbleBuilder: Builder {
    
    private let view: UIView
    private let imageView: UIImageView
    private let button: UIButton
    private let label: UILabel
    
    init() {
        self.view = UIView()
        self.imageView = UIImageView()
        self.button = UIButton()
        self.label = UILabel()
        
        setLayout()
        setUI()
    }
    
    private func setLayout() {
        
        self.view.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 209, height: 36))
        }
        
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalTo(view.snp.edges).inset(0)
        }
        
        self.view.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.leading).inset(10)
            $0.centerY.equalTo(imageView.snp.centerY).offset(3)
        }
        
        self.view.addSubview(button)
        button.snp.makeConstraints {
            $0.leading.equalTo(label.snp.trailing).offset(4)
            $0.centerY.equalTo(label.snp.centerY)
            $0.size.equalTo(16)
        }
    }
    
    private func setUI() {
        label.text = I18N.Home.bubbleTitle
        label.font = .captionM2
        label.textColor = .gbbGray400
        
        let action = UIAction { _ in self.view.removeFromSuperview() }
        button.addAction(action, for: .touchUpInside)
        button.setImage(.icDeleteKeyword, for: .normal)
    }
    
    func build() -> UIView {
        return self.view
    }
}

extension BubbleBuilder {
    
    func setImage(to image: UIImage) -> BubbleBuilder {
        imageView.image = image
        return self
    }
}
