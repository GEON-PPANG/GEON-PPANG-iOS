//
//  PaddingLabel.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import UIKit

final class PaddingLabel: UILabel {
    
    private var padding = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8) // 초기 패딩값 설정
    
    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize // label content size
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
}
