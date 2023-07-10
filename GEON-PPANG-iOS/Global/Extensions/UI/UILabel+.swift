//
//  UILabel+.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/03.
//

import UIKit

extension UILabel {
    /// 라벨 일부 textColor 변경해주는 함수
    /// - targetString에는 바꾸고자 하는 특정 문자열을 넣어주세요
    /// - textColor에는 targetString에 적용하고자 하는 특정 UIColor에 넣어주세요
    func partColorChange(targetString: String, textColor: UIColor) {
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.foregroundColor, value: textColor, range: range)
        self.attributedText = attributedString
    }
    
    /// 라벨 일부 font 변경해주는 함수
    /// - targerString에는 바꾸고자 하는 특정 문자열을 넣어주세요
    /// - font에는 targetString에 적용하고자 하는 UIFont를 넣어주세요
    func partFontChange(targetString: String, font: UIFont) {
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        
        attributedString.addAttribute(.font, value: font, range: range)
        self.attributedText = attributedString
    }
    
    /// 라벨 일부 font와 color 변경해주는 함수
    func setAttributedText(targetFontList: [String: UIFont],
                           targetColorList: [String: UIColor]) {
        let fullText = self.text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        for dic in targetFontList {
            let range = (fullText as NSString).range(of: dic.key)
            attributedString.addAttribute(.font, value: dic.value, range: range)
        }
        
        for dic in targetColorList {
            let range = (fullText as NSString).range(of: dic.key)
            attributedString.addAttribute(.foregroundColor, value: dic.value, range: range)
        }
        self.attributedText = attributedString
    }
}

extension UILabel {
    func basic(text: String? = "", font: UIFont, color: UIColor) {
        self.text = text ?? ""
        self.font = font
        self.textColor = color
    }
}
extension NSMutableAttributedString {
    func addImageInBetweenString(firstSentence: String, image: UIImage?, lastSentence: String) -> NSMutableAttributedString {
        
        let fullString = NSMutableAttributedString(string: firstSentence)
        
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = image
        image1Attachment.bounds = CGRect(x: 0, y: 0, width: 11, height: 11)
        let image1String = NSAttributedString(attachment: image1Attachment)
        
        fullString.append(image1String)
        fullString.append(NSAttributedString(string: lastSentence))
        
        return fullString
    }
}

extension NSAttributedString {
    func withLineSpacing(_ spacing: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: string.count))
        return NSAttributedString(attributedString: attributedString)
    }
}
