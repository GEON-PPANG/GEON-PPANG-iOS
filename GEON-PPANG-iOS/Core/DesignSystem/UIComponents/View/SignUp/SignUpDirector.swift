//
//  SignUpDirector.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 6/14/24.
//

import UIKit

public final class SignUpDirector {
    
    static func buildSignUpemail(text: String) -> UIView {
        let textField = TextFieldDirector.buildTextFieldWithoutRightView("이메일을 입력해주세요")
        return SignUpBuilder(textField)
            .setText(to: text)
            .build()
    }
    
    static func buildSignUpPassword(text: String) -> UIView {
        let textField = TextFieldDirector.buildTextFieldWithRightView("비밀번호를 입력해주세요", view: .icHide, secure: true)
        return SignUpBuilder(textField)
            .setText(to: text)
            .build()
    }
    
    static func buildSignInEmail(text: String) -> UIView {
        let button = DuplicatedButton()
        let textField = TextFieldDirector.buildTextFieldWithRightView("이메일을 입력해주세요", view: button)
        return SignUpBuilder(textField)
            .setText(to: text)
            .build()
    }
    
    static func buildSignInPassword(text: String) -> UIView {
        let textField = TextFieldDirector.buildTextFieldWithRightView("영문 , 숫자 포함 8자리 이상", view: .icHide, secure: true)
        return SignUpBuilder(textField)
            .setText(to: text)
            .build()
    }
    
    static func buildSignInCheckPassword(text: String) -> UIView {
        let textField = TextFieldDirector.buildTextFieldWithRightView("비밀번호를 입력해주세요", view: .icHide, secure: true)
        return SignUpBuilder(textField)
            .setText(to: text)
            .build()
    }
    
    static func buildSignInNickname(text: String) -> UIView {
        let textField = TextFieldDirector.buildTextFieldWithoutRightView("닉네임 8자 이내, 특수문자 금지")
        return SignUpBuilder(textField)
            .setText(to: text)
            .build()
    }
}
