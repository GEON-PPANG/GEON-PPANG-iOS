//
//  TextFieldDirector.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 6/14/24.
//

import UIKit

public final class TextFieldDirector {
    
    // Sign in & Sign up
    
    static func buildTextFieldWithoutRightView(_ text: String) -> UITextField {
        TextFieldBuilder()
            .setDescription(to: text)
            .build()
    }
    
    static func buildTextFieldWithRightView(_ text: String, view: UIImage, secure: Bool = false) -> UITextField {
        TextFieldBuilder()
            .setSecureTextEntry(to: secure)
            .setDescription(to: text)
            .setRightView(to: view, mode: .always)  
            .build()
    }
    
    static func buildTextFieldWithRightView(_ text: String, view: UIButton) -> UITextField {
        TextFieldBuilder()
            .setDescription(to: text)
            .setRightView(to: view)
            .build()
    }

    // Search
    
    static func buildHomeTextField() -> UITextField {
        TextFieldBuilder()
            .setDescription(to: "빵집·지역·역 명을 검색해 보세요!")
            .setCornerRadius(to:  CGFloat().convertByHeightRatio(22))
            .setBackgroundColor(to: .gbbGray100)
            .setLeftView(to: .icSearch400, mode: .always)
            .setLeftViewRect(forInsets: .init(top: 0,
                                              left: 15,
                                              bottom: 0,
                                              right: -15)
            )
            .build()
    }
    
    static func buildSerachTetField() -> UITextField {
        TextFieldBuilder()
            .setDescription(to: "빵집·지역·역 명을 검색해 보세요!")
            .setCornerRadius(to:  CGFloat().convertByHeightRatio(22))
            .setBackgroundColor(to: .gbbGray100)
            .setRightView(to: .icDelete, mode: .whileEditing)
            .setLeftView(to: .icSearch400, mode: .always)
            .setRect(forInsets: .init(top: 0,
                                      left: 12,
                                      bottom: 0,
                                      right: 15))
            .setRightViewRect(forInsets: .init(top: 0,
                                               left: -15,
                                               bottom: 0,
                                               right: 15))
            .setLeftViewRect(forInsets: .init(top: 0, 
                                              left: 15,
                                              bottom: 0,
                                              right: -15))
            .build()
    }
}
