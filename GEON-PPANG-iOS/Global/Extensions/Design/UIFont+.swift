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
    
    class var largeTitle: UIFont {
        return UIFont(name: "Pretendard-Bold", size: 32.0)!
    }
    
    class var title1: UIFont {
        return UIFont(name: "Pretendard-Bold", size: 26.0)!
    }
    
    class var title2: UIFont {
        return UIFont(name: "Pretendard-Bold", size: 20.0)!
    }
    
    class var headLine: UIFont {
        return UIFont(name: "Pretendard-Bold", size: 18.0)!
    }
    
    class var subHead: UIFont {
        return UIFont(name: "Pretendard-Medium", size: 15.0)!
    }
    
    class var bodyB1: UIFont {
        return UIFont(name: "Pretendard-Bold", size: 17.0)!
    }
    
    class var bodyM1: UIFont {
        return UIFont(name: "Pretendard-Medium", size: 17.0)!
    }
    
    class var bodyB2: UIFont {
        return UIFont(name: "Pretendard-Bold", size: 14.0)!
    }
    
    class var bodyM2: UIFont {
        return UIFont(name: "Pretendard-Medium", size: 14.0)!
    }
    
    class var captionB1: UIFont {
        return UIFont(name: "Pretendard-Bold", size: 13.0)!
    }
    
    class var captionM1: UIFont {
        return UIFont(name: "Pretendard-Medium", size: 13.0)!
    }
    
    class var captionM2: UIFont {
        return UIFont(name: "Pretendard-Medium", size: 11.0)!
    }
}
