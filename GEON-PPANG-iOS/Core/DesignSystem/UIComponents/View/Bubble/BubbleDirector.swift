//
//  BubbleDirector.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 6/26/24.
//

import UIKit

public final class BubbleDirector {
    
    static func buildBubbleToRight() -> UIView {
        BubbleBuilder()
            .setImage(to: .imgRightBubble)
            .build()
    }
    
    static func buildBubbleToLeft() -> UIView {
        BubbleBuilder()
            .setImage(to: .imgLeftBubble)
            .build()
    }
}
