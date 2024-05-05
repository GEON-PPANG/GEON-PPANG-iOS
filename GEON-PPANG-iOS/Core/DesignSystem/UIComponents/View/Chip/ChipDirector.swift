//
//  ChipDirector.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 5/5/24.
//

import UIKit

public final class ChipDirector {
    
    static func buildPointChip(with text: String) -> UIView {
        ChipBuilder()
            .setText(to: text)
            .setTextFont(to: .captionM1)
            .setTextColor(to: .gbbPoint1)
            .setCornerRadius(to: 3)
            .setBackgroundColor(to: .gbbPoint2)
            .setPadding(top: 4, right: 5, bottom: 4, left: 5)
            .build()
    }
    
}
