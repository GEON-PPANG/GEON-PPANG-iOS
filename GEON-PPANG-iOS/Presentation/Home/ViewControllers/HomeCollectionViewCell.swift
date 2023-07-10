//
//  HomeCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {
    
    //   private var bookMarkStatus: BookmarkStatus = .off
    
    private lazy var button = BookmarkButton(configuration: .plain())
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layer.applyShadow(alpha: 0.1, x: 0, y: 0, blur: 10)
        contentView.backgroundColor = .white
        contentView.makeCornerRound(radius: 5)
        contentView.clipsToBounds = true
        
        contentView.addSubview(button)
        
        //       button.do {
        //            $0.configuration?.title = "fnffn"
        //            $0.configuration?.imagePadding = 4
        //            $0.configuration?.imagePlacement = NSDirectionalRectEdge.top
        //            $0.configuration?.image = bookMarkStatus.icon
        //            $0.configuration?.baseForegroundColor = bookMarkStatus.color
        //            $0.configuration?.attributedTitle = AttributedString("fnffn", attributes: AttributeContainer([NSAttributedString.Key.font: UIFont.pretendardBold(17)]))
        //            $0.configurationUpdateHandler = { button in
        //                switch button.state {
        //                case .selected:
        //                    button.configuration?.image =  self.bookMarkStatus.icon
        //                    print("tapped")
        //                default:
        //                    button.configuration?.image = self.bookMarkStatus.icon
        //                }
        //            }
        
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(90)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
