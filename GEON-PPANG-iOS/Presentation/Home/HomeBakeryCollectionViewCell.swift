//
//  HomeBakeryCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import UIKit

import SnapKit
import Then
import Kingfisher

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
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        markStackView.getMarkStatus(false, false, false)
        markStackView.getIconImage(.bigHACCPMark, .bigVeganMark, .bigGMOMark)
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
        
        bakeryImage.do {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        
        markStackView.do {
            $0.getIconImage(.bigHACCPMark, .bigVeganMark, .bigGMOMark)
        }
        
        bakeryTitle.do {
            $0.basic(font: .bodyB1!, color: .gbbGray700!)
        }
        
        bakeryReview.do {
            $0.basic(font: .captionB1!, color: .gbbGray400!)
        }
        
        [bakeryTitle, bakeryReview].forEach {
            $0.do {
                $0.numberOfLines = 1
                $0.textAlignment = .left
            }
        }
    }
    
    private func setLayout() {
        contentView.addSubviews(bakeryImage, bakeryTitle, bakeryReview, regionStackView)
        bakeryImage.addSubview(markStackView)
        
        bakeryImage.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(118)
        }
        
        markStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10)
            $0.size.equalTo(CGSize(width: 68, height: 28))
        }
        
        bakeryTitle.snp.makeConstraints {
            $0.top.equalTo(bakeryImage.snp.bottom).offset(13)
            $0.leading.equalToSuperview().offset(16)
        }
        
        bakeryReview.snp.makeConstraints {
            $0.top.equalTo(bakeryTitle.snp.bottom).offset(9)
            $0.leading.equalTo(bakeryTitle.snp.leading)
        }
        
        regionStackView.snp.makeConstraints {
            $0.top.equalTo(bakeryReview.snp.bottom).offset(10)
            $0.leading.equalTo(bakeryTitle.snp.leading)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Custom Method
    
    func updateUI(data: BestBakery) {
        let url = URL(string: data.bakeryPicture)
        bakeryImage.kf.setImage(with: url)
        bakeryTitle.setLineHeight(by: 1.08, with: data.bakeryName)
        bakeryReview.setLineHeight(by: 1.09,
                                   with: "리뷰(\(data.reviewCount)) ⦁ 저장(\(data.bookMarkCount))")
        markStackView.getMarkStatus(data.isHACCP, data.isVegan, data.isNonGMO)
        if data.secondNearStation == "" {
            regionStackView.removeSecondRegion()
        }
        regionStackView.getRegionName(data.firstNearStation, data.secondNearStation ?? "")
    }
}
