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
    var subtitle: String
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
                        subtitle: "아토피, 알레르기, 당뇨, 소화불량 등이 있어요.",
                        selected: false),
        FilterCellModel(id: 2,
                        title: "맛 · 다이어트",
                        subtitle: "맛있어서 먹거나, 체중조절이 필요해요.",
                        selected: false),
        FilterCellModel(id: 3,
                        title: "비건 · 채식지향",
                        subtitle: "종교, 환경, 동물, 노동권 문제에 공감해요.",
                        selected: false)
    ]
    
    static var breadType = [
        FilterCellModel(id: 4,
                        title: "글루텐프리",
                        subtitle: "NO 글루텐",
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
                        subtitle: "NO 설탕\n(비설탕감미료)",
                        selected: false)
    ]
    
    static var ingredient = [
        FilterCellModel(id: 8,
                        title: "영양성분 보기",
                        subtitle: "영양성분까지 공개한 건빵집을 볼래요!",
                        selected: false),
        FilterCellModel(id: 9,
                        title: "원재료 보기",
                        subtitle: "원재료를 공개한 건빵집을 볼래요!",
                        selected: false),
        FilterCellModel(id: 10,
                        title: "모든 건빵집 보기",
                        subtitle: "일단 더 많은 건빵집을 볼래요!",
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
