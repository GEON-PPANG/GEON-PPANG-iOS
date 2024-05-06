//
//  ChipBuilder.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 5/5/24.
//

import UIKit
import SnapKit

internal protocol Builder {
    associatedtype View
    func build() -> View
}

internal final class ChipBuilder: Builder {
    
    private let view: UIView
    private let label: UILabel
    
    init() {
        self.view = UIView()
        self.label = UILabel()
        setLayout()
    }
    
    private func setLayout() {
        self.view.addSubview(label)
        self.label.snp.makeConstraints {
            $0.edges.equalTo(view.snp.edges).inset(0)
        }
    }
    
    func build() -> UIView {
        return self.view
    }
}

extension ChipBuilder {
    internal func setText(to text: String) -> ChipBuilder {
        self.label.text = text
        return self
    }
    
    internal func setTextColor(to color: UIColor) -> ChipBuilder {
        self.label.textColor = color
        return self
    }
    
    internal func setTextFont(to font: UIFont) -> ChipBuilder {
        self.label.font = font
        return self
    }
    
    internal func setCornerRadius(to amount: CGFloat) -> ChipBuilder {
        self.view.layer.masksToBounds = true
        self.view.layer.cornerRadius = amount
        return self
    }
    
    internal func setBackgroundColor(to color: UIColor) -> ChipBuilder {
        self.view.backgroundColor = color
        return self
    }
    
    internal func setBorderWidth(to width: CGFloat) -> ChipBuilder {
        self.view.layer.borderWidth = width
        return self
    }
    
    internal func setBorderColor(to color: UIColor) -> ChipBuilder {
        self.view.layer.borderColor = color.cgColor
        return self
    }
    
    internal func setPadding(
        top: CGFloat,
        right: CGFloat,
        bottom: CGFloat,
        left: CGFloat
    ) -> ChipBuilder {
        self.label.snp.updateConstraints {
            $0.top.equalTo(view.snp.top).inset(top)
            $0.right.equalTo(view.snp.right).inset(right)
            $0.bottom.equalTo(view.snp.bottom).inset(bottom)
            $0.left.equalTo(view.snp.left).inset(left)
        }
        return self
    }
}
