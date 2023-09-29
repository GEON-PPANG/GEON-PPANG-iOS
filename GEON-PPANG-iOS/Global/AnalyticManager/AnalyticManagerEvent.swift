//
//  AnalyticManagerEvent.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/09/15.
//

import Foundation

enum AnalyticManagerEvent {
    
    case general(General)
    case onboarding(Onboarding)
    case home(Home)
    case list(List)
    case detail(Detail)
    case writeReview(WriteReview)
    case myPage(MyPage)
}

extension AnalyticManagerEvent: AnalyticManagerEventProtocol {
    
    var name: String {
        switch self {
        case .general(let event):
            return event.name
        case .onboarding(let event):
            return event.name
        case .home(let event):
            return event.name
        case .list(let event):
            return event.name
        case .detail(let event):
            return event.name
        case .writeReview(let event):
            return event.name
        case .myPage(let event):
            return event.name
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .general(let event):
            return event.parameters
        case .onboarding(let event):
            return event.parameters
        case .home(let event):
            return event.parameters
        case .list(let event):
            return event.parameters
        case .detail(let event):
            return event.parameters
        case .writeReview(let event):
            return event.parameters
        default:
            return nil
        }
    }
}
