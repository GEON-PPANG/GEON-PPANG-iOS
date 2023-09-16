//
//  AnalyticEventType.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/09/17.
//

import Foundation

enum AnalyticEventType: String, CaseIterable {
    
    /// Auth
    
    case KAKAO
    case EMAIL
    case APPLE

    /// detilpage source
   
    case HOME
    case SEARCH
    case LIST
    case MYPAGE_MYSTORE
    case MYPAGE_MYREVIEW
}
