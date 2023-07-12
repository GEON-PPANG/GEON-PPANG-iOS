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
    
}
