//
//  FilterModel.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/08/18.
//

import Foundation

struct FilterCellModel: Identifiable {
    var id: Int
    var title: String
    var subtitle: String?
    var selected: Bool
    
    init(id: Int = 0, title: String = "", subtitle: String = "", selected: Bool = false) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.selected = selected
    }
}

extension FilterCellModel {
    
    static var purpose = [
        FilterCellModel(id: 1,
                    title: "건강 · 체질",
                    subtitle: "아토피, 알레르기, 암, 당뇨, 소화문제",
                    selected: false),
        FilterCellModel(id: 2,
                    title: "맛 · 다이어트",
                    subtitle: "그냥 맛있어서! 식이 관리를 위해",
                    selected: false),
        FilterCellModel(id: 3,
                    title: "비건 · 채식지향",
                    subtitle: "종교, 환경, 동물, 노동권을 위한 비거니즘",
                    selected: false)
    ]
    
    static var breadType = [
        FilterCellModel(id: 4,
                    title: "글루텐프리",
                    subtitle: "NO 글루텐\nLOW 글루텐",
                    selected: false),
        FilterCellModel(id: 5,
                    title: "비건빵",
                    subtitle: "NO 동물성재료\n(유제품, 계란 등)",
                    selected: false),
        FilterCellModel(id: 6,
                    title: "넛프리",
                    subtitle: "NO 견과류",
                    selected: false),
        FilterCellModel(id: 7,
                    title: "대체당",
                    subtitle: "알룰로스, 스테비아,\n에리스리톨, 말티톨 등",
                    selected: false)
    ]
    
    static var ingredient = [
        FilterCellModel(id: 8,
                    title: "영양성분까지 꼼꼼히 볼래요!",
                    selected: false),
        FilterCellModel(id: 9,
                    title: "어떤 재료가 들어갔는지 볼래요!",
                    selected: false),
        FilterCellModel(id: 10,
                    title: "성분 정보는 괜찮아요!",
                    selected: false)
    ]
    
}

extension FilterCellModel {
    
    static func item(of id: Int) -> FilterCellModel {
        
        let allItems = FilterCellModel.purpose + FilterCellModel.breadType + FilterCellModel.ingredient
        guard let item = allItems.first(where: { $0.id == id })
        else { return FilterCellModel.init() }
        return item
    }
    
    static func configureSelection(of type: FilterType,
                                   at index: Int,
                                   to value: Bool) {
        
        switch type {
        case .purpose:
            FilterCellModel.purpose[index].selected = value
        case .breadType:
            FilterCellModel.breadType[index].selected = value
        case .ingredient:
            FilterCellModel.ingredient[index].selected = value
        }
    }
    
    static func deselectContents(of type: FilterType) {
        
        switch type {
        case .purpose:
            [0, 1, 2].forEach {
                FilterCellModel.purpose[$0].selected = false
            }
        case .breadType:
            [0, 1, 2, 3].forEach {
                FilterCellModel.breadType[$0].selected = false
            }
        case .ingredient:
            [0, 1, 2].forEach {
                FilterCellModel.ingredient[$0].selected = false
            }
        }
    }
    
    static func isAnySelected(of filters: FilterType) -> Bool {
        
        switch filters {
        case .purpose:
            return !FilterCellModel.purpose.filter { $0.selected == true }.isEmpty
        case .breadType:
            return !FilterCellModel.breadType.filter { $0.selected == true }.isEmpty
        case .ingredient:
            return !FilterCellModel.ingredient.filter { $0.selected == true }.isEmpty
        }
    }
    
}
