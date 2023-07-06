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
    
    static let largeTitle = UIFont(name: "Pretendard-Bold", size: 32.0)

    static let title1 = UIFont(name: "Pretendard-Bold", size: 26.0)
    
    static let title2 = UIFont(name: "Pretendard-Bold", size: 20.0)
    
    static let headLine = UIFont(name: "Pretendard-Bold", size: 18.0)
    
    static let subHead = UIFont(name: "Pretendard-Medium", size: 15.0)
    
    static let bodyB1 = UIFont(name: "Pretendard-Bold", size: 17.0)
    
    static let bodyM1 = UIFont(name: "Pretendard-Medium", size: 17.0)
    
    static let bodyB2 = UIFont(name: "Pretendard-Bold", size: 14.0)
    
    static let bodyM2 = UIFont(name: "Pretendard-Medium", size: 14.0)
    
    static let captionB1 = UIFont(name: "Pretendard-Bold", size: 13.0)
    
    static let captionM1 = UIFont(name: "Pretendard-Medium", size: 13.0)
    
    static let captionM2 = UIFont(name: "Pretendard-Medium", size: 11.0)
}
