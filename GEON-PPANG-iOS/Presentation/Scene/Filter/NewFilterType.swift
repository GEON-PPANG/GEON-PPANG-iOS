//
//  FilterType.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 7/6/24.
//

import UIKit

enum NewFilterType: Int {
    case purpose = 1
    case breadType = 2
    case ingredient = 3
}

extension NewFilterType {
    var title: String {
        switch self {
        case .purpose: "맞춤 빵집 추천을 위해\n건빵을 찾은 이유를 알려주세요!"
        case .breadType: "어떤 빵을 원하시나요?"
        case .ingredient: "원하시는 성분공개 정도를\n선택해주세요!"
        }
    }
    
    var description: String? {
        switch self {
        case .purpose: nil
        case .breadType: "중복선택이 가능해요!"
        case .ingredient: nil
        }
    }
    
    var dataSource: [(title: String, description: String)] {
        switch self {
        case .purpose:
            [
                ("건강 · 체질", "아토피, 알레르기, 당뇨, 소화불량 등이 있어요."),
                ("맛 · 다이어트", "맛있어서 먹거나, 체중조절이 필요해요."),
                ("비건 · 채식지향", "종교, 환경, 동물, 노동권 문제에 공감해요."),
            ]
        case .breadType:
            [
                ("글루텐프리", "NO 글루텐"),
                ("비건빵", "NO 동물성재료\n(유제품, 계란 등)"),
                ("넛프리", "NO 견과류"),
                ("대체당", "NO 설탕\n(비설탕감미료)"),
            ]
            
        case .ingredient:
            [
                ("영양성분 보기", "영양성분까지 공개한 건빵집을 볼래요!"),
                ("원재료 보기", "원재료를 공개한 건빵집을 볼래요!"),
                ("모든 건빵집 보기", "일단 더 많은 건빵집을 볼래요!"),
            ]
        }
    }
    
    var layout: UICollectionViewLayout {
        switch self {
        case .purpose, .ingredient:
            return UICollectionViewCompositionalLayout { _, _ in
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(100)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(100)
                )
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 20
                return section
            }
            
        case .breadType:
            return UICollectionViewCompositionalLayout { _, _ in
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.45),
                    heightDimension: .absolute(161)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(161)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let itemSpacing = NSCollectionLayoutSpacing.flexible(20)
                group.interItemSpacing = itemSpacing
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = itemSpacing.spacing
                return section
            }
        }
    }
}
