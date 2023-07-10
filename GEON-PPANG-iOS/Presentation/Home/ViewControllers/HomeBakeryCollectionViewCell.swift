//
//  HomeBakeryCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class HomeBakeryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    // MARK: - UI Property
    
    private let bakeryImage = UIImageView()
    private let bakeryTitle = UILabel()
    private let bakeryReview = UILabel()
    private lazy var bookMarkButton = BookmarkButton(configuration: .plain())
    
    // MARK: - Life Cycle
    
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
            $0.layer.applyShadow(alpha: 0.1, x: 0, y: 0, blur: 10)
            $0.contentView.backgroundColor = .white
            $0.contentView.makeCornerRound(radius: 5)
            $0.contentView.clipsToBounds = true
        }
        
        bakeryImage.do {
            $0.contentMode = .scaleAspectFill
            $0.backgroundColor = .gbbPoint1
        }
        
        bookMarkButton.do {
            $0.configuration?.imagePadding = 4
            $0.configuration?.imagePlacement = NSDirectionalRectEdge.top
        }
        [bakeryTitle, bakeryReview].forEach {
            $0.numberOfLines = 1
            $0.textAlignment = .left
            $0.basic(font: .pretendardBold(14), color: .gbbGray700!)
        }
    }
    
    private func setLayout() {
        contentView.addSubviews(bakeryImage, bookMarkButton, bakeryTitle, bakeryReview)
        
        let availableHeight = contentView.bounds.height
        let buttonHeight: CGFloat = 60
        let buttonTopOffset = (availableHeight - buttonHeight) / 2
        
        bakeryImage.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(118)
        }
        
        bookMarkButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(bakeryReview.snp.bottom).offset(buttonTopOffset)
            $0.size.equalTo(CGSize(width: 34, height: 60))
        }
        
        bakeryTitle.snp.makeConstraints {
            $0.top.equalTo(bakeryImage.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(13)
            $0.trailing.equalTo(bookMarkButton.snp.leading).offset(-14)
        }
        
        bakeryReview.snp.makeConstraints {
            $0.top.equalTo(bakeryTitle.snp.bottom).offset(10)
            $0.leading.equalTo(bakeryTitle.snp.leading)
            $0.trailing.equalTo(bookMarkButton.snp.leading).offset(-20)

        }
    }
    
    func updateUI(data: HomeBestBakeryResponseDTO) {
        bakeryImage.image = UIImage(named: data.bakeryPicture)
        bakeryTitle.text = data.bakeryName
        bakeryReview.text = "리뷰(\(data.reviewCount))"
        bakeryReview.partColorChange(targetString: "\(data.reviewCount)", textColor: .gbbPoint1!)
        bookMarkButton.getCount(data.bookmarkCount)
        if data.isBooked {
            bookMarkButton.updateBookMarkUI(.off)
        } else {
            bookMarkButton.updateBookMarkUI(.on)

        }
    }
}
