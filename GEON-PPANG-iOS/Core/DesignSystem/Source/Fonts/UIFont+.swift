//
//  UIFont+.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/03.
//

import UIKit

extension UIFont {
    
    // 사용 예시)
    // $0.font = .pretendardBold(32)
    // $0.font = .largeTitle
    
    static func pretendardBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Bold", size: size)!
    }
    
    static func pretendardMedium(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Medium", size: size)!
    }
    
    static let largeTitle: UIFont = .pretendardBold(32.0)

    static let title1: UIFont = .pretendardBold(26.0)
    
    static let title2: UIFont = .pretendardBold(20.0)
    
    static let headLine: UIFont = .pretendardMedium(18.0)
    
    static let subHead: UIFont = .pretendardMedium(15.0)
    
    static let bodyB1: UIFont = .pretendardBold(17.0)
    
    static let bodyM1: UIFont = .pretendardMedium(17.0)
    
    static let bodyB2: UIFont = .pretendardBold(14.0)
    
    static let bodyM2: UIFont = .pretendardMedium(14.0)
    
    static let captionB1: UIFont = .pretendardBold(13.0)
    
    static let captionM1: UIFont = .pretendardMedium(13.0)
    
    static let captionM2: UIFont = .pretendardMedium(11.0)
}
