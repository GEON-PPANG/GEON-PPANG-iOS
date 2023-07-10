//
//  BookmarkButton.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import UIKit

import SnapKit
import Then

enum BookmarkStatus {
    case on, off
    
    var icon: UIImage? {
        switch self {
        case .on:
            return .enabledBookmarkButton
        case .off:
            return .disabledBookmarkButton
        }
    }
    
    var color: UIColor? {
        switch self {
        case .on:
            return .gbbPoint1
        case .off:
            return .clear
        }
    }
}

final class BookmarkButton: UIButton {
    
    private var bookMarkStatus: BookmarkStatus = .on {
        didSet {
            if bookMarkStatus == .off {
                bookMarkStatus = .on
            } else {
                bookMarkStatus = .off
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.do {
            $0.configuration?.imagePadding = 4
            $0.configuration?.imagePlacement = NSDirectionalRectEdge.top
            $0.configuration?.image = bookMarkStatus.icon
            $0.configuration?.baseForegroundColor = bookMarkStatus.color
            $0.configurationUpdateHandler = { button in
                switch button.state {
                case .selected:
                    button.configuration?.image =  self.bookMarkStatus.icon
                default:
                    button.configuration?.image = self.bookMarkStatus.icon
                }
            }
            
        }
    }
    
    private func setLayout() {
        
    }
    
    func updateBookMarkUI(_ state: BookmarkStatus) {
        self.bookMarkStatus = state
        setUI()
    }
    
    func getCount(_ count: Int) {
        if count == 0 {
            configuration?.attributedTitle = ""
        } else {
            configuration?.attributedTitle = AttributedString("\(count)명", attributes: AttributeContainer([.font: UIFont.pretendardBold(17), .foregroundColor: UIColor.gbbPoint1!]))
        }
    }
}
