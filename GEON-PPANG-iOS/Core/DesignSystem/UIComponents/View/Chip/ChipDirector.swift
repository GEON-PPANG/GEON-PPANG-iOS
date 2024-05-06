//
//  ChipDirector.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 5/5/24.
//

import UIKit

public final class ChipDirector {
    
    static func buildPointChip(_ text: String) -> UIView {
        ChipBuilder()
            .setText(to: text)
            .setTextFont(to: .captionM1)
            .setTextColor(to: .gbbPoint1)
            .setCornerRadius(to: 3)
            .setBackgroundColor(to: .gbbPoint2)
            .setPadding(top: 4, right: 5, bottom: 4, left: 5)
            .build()
    }
    
    static func buildPointChipWithRoundCorner(_ text: String) -> UIView {
        ChipBuilder()
            .setText(to: text)
            .setTextFont(to: .captionM1)
            .setTextColor(to: .gbbPoint1)
            .setCornerRadius(to: 12.5)
            .setBackgroundColor(to: .gbbPoint2)
            .setBorderColor(to: .gbbPoint1)
            .setBorderWidth(to: 0.5)
            .setPadding(top: 4, right: 11, bottom: 4, left: 11)
            .build()
    }
    
    static func buildGrayChipWithBorder(_ text: String) -> UIView {
        ChipBuilder()
            .setText(to: text)
            .setTextFont(to: .captionM1)
            .setTextColor(to: .gbbGray400)
            .setCornerRadius(to: 3)
            .setBackgroundColor(to: .gbbBackground1)
            .setBorderColor(to: .gbbGray300)
            .setBorderWidth(to: 0.5)
            .setPadding(top: 4, right: 6, bottom: 4, left: 6)
            .build()
    }
    
    static func buildPointChipWithBorder(_ text: String) -> UIView {
        ChipBuilder()
            .setText(to: text)
            .setTextFont(to: .captionM1)
            .setTextColor(to: .gbbPoint1)
            .setCornerRadius(to: 3)
            .setBackgroundColor(to: .gbbBackground1)
            .setBorderColor(to: .gbbPoint1)
            .setBorderWidth(to: 0.5)
            .setPadding(top: 2, right: 6, bottom: 2, left: 6)
            .build()
    }
}
