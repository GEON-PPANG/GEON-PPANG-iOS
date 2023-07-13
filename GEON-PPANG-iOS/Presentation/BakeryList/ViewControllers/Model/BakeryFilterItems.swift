//
//  BakeryFilterItems.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/11.
//

import UIKit

enum Status {
    case on, off
}

enum Filter {
    case HARD
    case DESSERT
    case BRUNCH
    
    var title: String {
        switch self {
        case .HARD:
            return "하드빵류"
        case .DESSERT:
            return "디저트류"
        case .BRUNCH:
            return "브런치류"
        }
    }
}

struct BakeryFilterItems: Hashable {
    var identifier = UUID()
    var filter: Filter
    var status: Status
    var leftIcon: UIImage
    static var item: [BakeryFilterItems] = [BakeryFilterItems(filter: .HARD, status: .off, leftIcon: .disabledHardIcon),
                                            BakeryFilterItems(filter: .DESSERT, status: .off, leftIcon: .disabledCakeIcon),
                                            BakeryFilterItems(filter: .BRUNCH, status: .off, leftIcon: .disabledSandwichIcon)
    ]
    
    public func isSelected() -> Self {
        switch self.status {
        case .off:
            switch self.filter {
            case .HARD:
                return BakeryFilterItems(filter: filter, status: status, leftIcon: .disabledHardIcon)
            case .DESSERT:
                return BakeryFilterItems(filter: filter, status: .off, leftIcon: .disabledCakeIcon)
            case .BRUNCH:
                return BakeryFilterItems(filter: filter, status: .off, leftIcon: .disabledSandwichIcon)
            }
            
        case .on:
            switch self.filter {
            case .HARD:
                return BakeryFilterItems(filter: filter, status: status, leftIcon: .enabledHardIcon)
            case .DESSERT:
                return BakeryFilterItems(filter: filter, status: status, leftIcon: .enabledCakeIcon)
            case .BRUNCH:
                return BakeryFilterItems(filter: filter, status: status, leftIcon: .enabledSandwichIcon)
            }
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func == (lhs: BakeryFilterItems, rhs: BakeryFilterItems) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
