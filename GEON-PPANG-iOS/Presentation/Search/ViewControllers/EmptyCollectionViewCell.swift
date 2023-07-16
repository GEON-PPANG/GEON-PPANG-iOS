//
//  EmptyCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/12.
//

import UIKit

import SnapKit
import Then

enum EmptyType: String {
    case noReview = "작성된 리뷰가 없어요!"
    case noBookmark = "저장 목록이 없어요!"
    case noSearch = "검색결과가 없어요\n다른 키워드로 검색해보세요!"
    case initialize = "궁금하신 건빵집을\n검색해보세요!"
    
    var icon: UIImage {
        switch self {
        case .noReview: return .noReviewImage
        case .noBookmark: return .noBookmarkImage
        case .noSearch: return .noSearchResultImage
        case .initialize: return .searchImage
        }
    }
}

final class EmptyCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    private var emptyType: EmptyType = .initialize
    
    // MARK: - UI Property
    
    private let emptyIcon = UIImageView()
    private let emptyLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        addSubviews(emptyIcon, emptyLabel)
        
        emptyIcon.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 154, height: 132))
            $0.centerX.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(emptyIcon.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            
            switch emptyType {
            case .initialize, .noSearch:
                $0.centerY.equalToSuperview().inset(-33)
            case .noReview, .noBookmark:
                $0.centerY.equalToSuperview().inset(-22)
            }
        }
    }
    
    private func setUI() {
        emptyIcon.do {
            $0.contentMode = .scaleAspectFit
        }
        
        emptyLabel.do {
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.basic(font: .title2!, color: .gbbGray300!)
        }
    }
    
    func getViewType(_ type: EmptyType) {
        emptyType = type
        emptyIcon.image = type.icon
        emptyLabel.text = type.rawValue
        
        switch type {
        case .initialize, .noBookmark, .noReview:
            return emptyLabel.basic(text: emptyType.rawValue, font: .title2!, color: .gbbGray300!)
        case .noSearch:
            return emptyLabel.partFontChange(targetString: "다른 키워드로 검색해보세요!", font: .subHead!)
        }
    }
    
    func getEmtyText(_ text: String) {
        emptyLabel.text = text
    }
}
