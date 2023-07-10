//
//  HomeReviewCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class HomeReviewCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    var updateData: ((Bool, Int) -> Void)?
    var index = 0
    
    // MARK: - UI Property
    
    private lazy var bakeryImage = GradientImageView(colors: [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.3).cgColor])
    private let reviewTitle = UILabel()
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
    
    // MARK: - Setting
    
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
            $0.configuration?.contentInsets = .zero
        }
        
        reviewTitle.do {
            $0.basic(font: .pretendardBold(14), color: .white)
            $0.numberOfLines = 2
        }
        
        [bakeryTitle, bakeryReview].forEach {
            $0.numberOfLines = 1
            $0.textAlignment = .left
            $0.basic(font: .pretendardBold(14), color: .gbbGray700!)
        }
    }
    
    private func setLayout() {
        contentView.addSubviews(bakeryImage, bookMarkButton, bakeryReview, bakeryTitle)
        bakeryImage.addSubview(reviewTitle)
        
        bakeryImage.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(CGFloat().convertByHeightRatio(170))
        }
        
        bookMarkButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(19)
            $0.trailing.equalToSuperview().offset(-19)
            $0.size.equalTo(34)
        }
        
        reviewTitle.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().offset(-13)
        }
        bakeryReview.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-18)
            $0.leading.equalToSuperview().offset(15)
        }
        
        bakeryTitle.snp.makeConstraints {
            $0.bottom.equalTo(bakeryReview.snp.top).offset(-4)
            $0.leading.equalToSuperview().offset(15)
        }
        
    }
    
    func updateUI(data: HomeBestReviewResponseDTO, index: Int) {
        self.index = index
        reviewTitle.text = data.reviewText
        bakeryTitle.text = data.bakeryName
        bakeryReview.text = "리뷰(\(data.reviewCount))"
        bakeryReview.partColorChange(targetString: "\(data.reviewCount)", textColor: .gbbPoint1!)
        bookMarkButton.updateData = { [weak self] status in
            guard let self = self  else { return }
            self.updateData?(status, self.index)
        }
        if data.isBooked {
            bookMarkButton.isSelected = true
        } else {
            bookMarkButton.isSelected = false
        }
    }
}
