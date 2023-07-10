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
    
    var updateData: ((Bool, Int) -> Void)?
    var index = 0
    
    // MARK: - UI Property
    
    private let bakeryImage = UIImageView()
    private let markStackView = MarkStackView()
    private let bakeryTitle = UILabel()
    private let bakeryReview = UILabel()
    private let regionStackView = RegionStackView()
    private lazy var bookMarkButton = BookmarkButton(configuration: .plain())
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        markStackView.getMarkStatus(false, false, false)
    }
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
        bookMarkButton.do {
            $0.configuration?.imagePlacement = NSDirectionalRectEdge.top
            $0.configuration?.imagePadding = 4
            $0.configuration?.contentInsets = .zero
        }
        bakeryImage.do {
            $0.contentMode = .scaleAspectFill
            $0.backgroundColor = .gbbPoint1
        }
        
        [bakeryTitle, bakeryReview].forEach {
            $0.numberOfLines = 1
            $0.textAlignment = .left
            $0.basic(font: .pretendardBold(14), color: .gbbGray700!)
        }
    }
    
    private func setLayout() {
        contentView.addSubviews(bakeryImage, bookMarkButton, bakeryTitle, bakeryReview, regionStackView)
        bakeryImage.addSubview(markStackView)
        
        let availableHeight = contentView.bounds.height
        let buttonHeight: CGFloat = 60
        let buttonTopOffset = (availableHeight - buttonHeight) / 2
        
        bakeryImage.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(118)
        }
        
        markStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10)
            $0.size.equalTo(CGSize(width: 67, height: 28))
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
        
        regionStackView.snp.makeConstraints {
            $0.top.equalTo(bakeryReview.snp.bottom).offset(10)
            $0.leading.equalTo(bakeryTitle.snp.leading)
            $0.bottom.equalToSuperview().offset(-19)
        }
    }
    
    func updateUI(data: HomeBestBakeryResponseDTO, index: Int) {
        self.index = index
        bakeryImage.image = UIImage(named: data.bakeryPicture)
        bakeryTitle.text = data.bakeryName
        bakeryReview.text = "리뷰(\(data.reviewCount))"
        bakeryReview.partColorChange(targetString: "\(data.reviewCount)", textColor: .gbbPoint1!)
        bookMarkButton.getCount(data.bookmarkCount)
        bookMarkButton.updateData = { [weak self] status in
            guard let self = self  else { return }
            self.updateData?(status, self.index)
        }
        if data.isBooked {
            bookMarkButton.isSelected = true
        } else {
            bookMarkButton.isSelected = false
        }
        markStackView.getMarkStatus(data.isHACCP, data.isVegan, data.isNONGMO)
        
        if data.secondNearStation == "" {
            regionStackView.removeSecondRegion()
        }
        regionStackView.getGegionName(data.firstNearStation, data.secondNearStation)
        
    }
}
