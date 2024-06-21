//
//  TextFieldDirector.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 6/14/24.
//

import UIKit

public final class TextFieldDirector {
    
    static func buildHomeTextField() -> UITextField {
        TextFieldBuilder()
            .setRightView(to: .icSearch400, mode: .always)
            .setRightViewRect(forInsets: .init(top: 0, left: 15, bottom: 0, right: -15))
            .build()
    }

    static func buildSearchTextField() -> UITextField {
        TextFieldBuilder()
            .setClearAction()
            .setRect(forInsets: .init(top: 0, left: 12, bottom: 0, right: 15))
            .setLeftView(to: .icSearch400, mode: .always)
            .setLeftViewRect(forInsets: .init(top: 0, left: 15, bottom: 0, right: -15))
            .setRightView(to: .icDelete, mode: .whileEditing)
            .setRightViewRect(forInsets: .init(top: 0, left: -15, bottom: 0, right: 15))
            .build()
    }
}
