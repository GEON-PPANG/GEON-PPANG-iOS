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
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isContainEnglish() -> Bool {
        
        let pattern = "[A-Za-z]+"
        return self.range(of: pattern, options: .regularExpression) != nil
    }
    
    func isContainNumber() -> Bool {
        
        let pattern = ".*[0-9]+.*"
        return self.range(of: pattern, options: .regularExpression) != nil
    }
    
    /// 비밀번호
    func isContainNumberAndAlphabet() -> Bool {
        
        let pattern = "^(?=.*[0-9])(?=.*[a-zA-Z]).{8,}$"
        return self.range(of: pattern, options: .regularExpression) != nil
    }
    
    /// nickName
    func isNotContainSpecialCharacters() -> Bool {
        
        let pattern = "^[0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ\\s]{0,10}$"
        return self.range(of: pattern, options: .regularExpression) != nil
    }
}
