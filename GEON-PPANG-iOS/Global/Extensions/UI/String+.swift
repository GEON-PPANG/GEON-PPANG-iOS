//
//  String+.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/12.
//

import Foundation

extension String {
    
    func insertString(_ string: String, at index: Int) -> String {
        var newString = self
        let stringIndex = self.index(self.startIndex, offsetBy: index)
        newString.insert(contentsOf: string, at: stringIndex)
        return newString
    }
    
    /// 이메일
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isContainEnglish() -> Bool {
        let pattern = "[A-Za-z]+"
        guard let isContain = self.range(of: pattern, options: .regularExpression) else { return false}
        return true
    }
    
    func isContainNumber() -> Bool {
        let pattern = ".*[0-9]+.*"
        guard let isContain = self.range(of: pattern, options: .regularExpression) else { return false}
        return true
    }
    
    /// 비밀번호
    func isContainNumberAndAlphabet() -> Bool {
        let pattern = "^[0-9a-zA-Z]{8,}$"
        guard let isContain = self.range(of: pattern, options: .regularExpression) else { return false}
        return true
    }
    
    /// nickName
    func isNotContainSpecialCharacters() -> Bool {
        let pattern = "^[0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ\\s]{0,10}$"
        guard let isContain = self.range(of: pattern, options: .regularExpression) else { return false}
        return true
    }
}
