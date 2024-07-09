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
    
    // MARK: - UI Property
    
    private let bakeryImage = UIImageView()
    private let markStackView = MarkStackView()
 //   private var markStackView: GBStackView
    private let bakeryTitle = UILabel()
    private let reviewCount = IconWithTextView(.reviews)
    private let bookmarkCount = IconWithTextView(.bookmark)
    private let regionStackView = RegionStackView()
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        markStackView.getMarkStatus(false, false, false)
        markStackView.configureIconImage(.bigHACCPMark, .bigVeganMark, .bigGMOMark)
        regionStackView.arrangedSubviews.forEach {
            regionStackView.removeArrangedSubview($0)
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
    
    // MARK: - Setting
    
    private func setLayout() {
        
        contentView.addSubview(bakeryImage)
        bakeryImage.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(heightConsideringNotch(118))
        }
        
        contentView.addSubview(bakeryTitle)
        bakeryTitle.snp.makeConstraints {
            $0.top.equalTo(bakeryImage.snp.bottom).offset(13)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(bookmarkCount)
        bookmarkCount.snp.makeConstraints {
            $0.top.equalTo(bakeryTitle.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        contentView.addSubview(reviewCount)
        reviewCount.snp.makeConstraints {
            $0.top.equalTo(bakeryTitle.snp.bottom).offset(9)
            $0.leading.equalTo(bookmarkCount.snp.trailing).offset(6)
        }
        
        contentView.addSubview(regionStackView)
        regionStackView.snp.makeConstraints {
            $0.top.equalTo(bookmarkCount.snp.bottom).offset(13)
            $0.leading.equalTo(bakeryTitle.snp.leading)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        bakeryImage.addSubview(markStackView)
        markStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10)
            $0.size.equalTo(CGSize(width: heightConsideringNotch(68), height: heightConsideringNotch(28)))
        }
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
            $0.clipsToBounds = true
        }
        
//        markStackView.do {
//            $0.configureIconImage(.bigHACCPMark, .bigVeganMark, .bigGMOMark)
//        }
//        
        bakeryTitle.do {
            $0.numberOfLines = 1
            $0.basic(font: .bodyB1!, color: .gbbGray700!)
            $0.sizeToFit()
        }
        
    }
    
    // MARK: - Custom Method
    
    func configureCellUI(data: BestBakery) {
        
        let url = URL(string: data.overview.image)
        bakeryImage.kf.setImage(with: url, placeholder: UIImage.loading_large)
        bakeryTitle.setLineHeight(by: 1.08, with: data.overview.name)
        bakeryTitle.lineBreakMode = .byTruncatingTail
        
        bookmarkCount.configureHomeCell(count: data.bookmarkCount)
        reviewCount.configureHomeCell(count: data.reviewCount)
     //   markStackView = GBStackView(type: .big, data: [data.certifications.isHaccp,
//                                                       data.certifications.isVegan,
//                                                       data.certifications.isNonGMO
//                                                      ])
//        markStackView.getMarkStatus(data.certifications.isHaccp,
//                                    data.certifications.isVegan,
//                                    data.certifications.isNonGMO)
        
        if data.regions.secondRegion == "" {
            regionStackView.removeSecondRegion()
        }
        
        regionStackView.configureRegion(data.regions)
    }
}


enum GBStackType {
    case big
    case small
    
    var images: [UIImage]{
        switch self {
        case .big:
            return [.bigHACCPMark, .bigVeganMark, .bigGMOMark]
        case .small:
            return [.smallHACCPMark, .smallVeganMark, .smallGMOMark]
        }
    }
    
    var size: Int {
        switch self {
        case .big:
            return 28
        case .small:
            return 24
        }
    }
}

final class GBStackView: UIStackView {
    
    init(type: GBStackType, data: [Bool]) {
        super.init(frame: .zero)
        
        setUI()
        createCells(type: type, from: data).forEach { view in
            self.addArrangedSubview(view)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createCells(type: GBStackType, from data: [Bool]) -> [UIImageView] {
        let images = type.images
        var imageIndex = 0
        
        return data.compactMap { isCertified in
            defer { imageIndex += 1 }
            guard isCertified, imageIndex < images.count else { return nil }
            let imageView = UIImageView(image: images[imageIndex])
            imageView.contentMode = .topLeft
            imageView.snp.makeConstraints {  $0.size.equalTo(type.size) }
            return imageView
        }
    }
    
    private func setLayout() {
        
    }
    
    private func setUI() {
        self.axis = .horizontal
        self.spacing = -8
    }
}

