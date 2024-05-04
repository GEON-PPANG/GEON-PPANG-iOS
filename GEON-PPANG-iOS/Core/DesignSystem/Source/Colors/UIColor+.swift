//
//  UIColor+.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/06.
//

import UIKit

extension UIColor {
    
    // 사용 예시)
    // $0.textColor = .gbbMain1
    // $0.backgroundColor = .gbbBackground1
    
    // MARK: - main colors
    static let gbbMain1: UIColor = UIColor(named: "Main_1")!
    static let gbbMain2: UIColor = UIColor(named: "Main_2")!
    static let gbbMain3: UIColor = UIColor(named: "Main_3")!
    
    // MARK: - point colors
    static let gbbPoint1: UIColor = UIColor(named: "Point_1")!
    static let gbbPoint2: UIColor = UIColor(named: "Point_2")!
    
    // MARK: - error colors
    static let gbbError: UIColor = UIColor(named: "Error")!
    
    // MARK: - background colors
    static let gbbBackground1: UIColor = UIColor(named: "Background_1")!
    static let gbbBackground2: UIColor = UIColor(named: "Background_2")!
    static let gbbAlertBackground: UIColor = UIColor(named: "alert-gray")!
    
    // MARK: - grayscale colors
    static let gbbWhite: UIColor = UIColor(named: "Gray_Scale/white")!
    static let gbbGray100: UIColor = UIColor(named: "Gray_Scale/gray-100")!
    static let gbbGray200: UIColor = UIColor(named: "Gray_Scale/gray-200")!
    static let gbbGray300: UIColor = UIColor(named: "Gray_Scale/gray-300")!
    static let gbbGray400: UIColor = UIColor(named: "Gray_Scale/gray-400")!
    static let gbbGray500: UIColor = UIColor(named: "Gray_Scale/gray-500")!
    static let gbbGray600: UIColor = UIColor(named: "Gray_Scale/gray-600")!
    static let gbbGray700: UIColor = UIColor(named: "Gray_Scale/gray-700")!
    static let gbbBlack: UIColor = UIColor(named: "Gray_Scale/black")!
    
}

extension UIColor {
    public convenience init(hex hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
