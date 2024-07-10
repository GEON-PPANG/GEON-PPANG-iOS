//
//  HomeBakeryCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import UIKit

import SnapKit
import Kingfisher

final class HomeBakeryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private let reviewCount = IconWithTextView(.reviews)
    private let bookmarkCount = IconWithTextView(.bookmark)
    private let regionStackView = RegionStackView()
 //   private var markStackView: GBStackView?
    private let bakeryImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let bakeryTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .bodyB1
        label.textColor = .gbbGray700
        label.sizeToFit()
        return label
    }()
    
    // MARK: - Init
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
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
    }
    
    private func setUI() {
        layer.applyShadow(alpha: 0.1, x: 0, y: 0, blur: 10)
        contentView.backgroundColor = .white
        contentView.makeCornerRound(radius: 5)
        contentView.clipsToBounds = true
    }
    
    // MARK: - Custom Method
    
    func configureCellUI(data: BestBakery) {
        
        let url = URL(string: data.overview.image)
        bakeryImage.kf.setImage(with: url, placeholder: UIImage.loading_large)
        bakeryTitle.setLineHeight(by: 1.08, with: data.overview.name)
        bakeryTitle.lineBreakMode = .byTruncatingTail
        
        bookmarkCount.configureHomeCell(count: data.bookmarkCount)
        reviewCount.configureHomeCell(count: data.reviewCount)
        
        self.configureStackView(with: data.certifications)
        
        // cell builder 머지 후 변경
        
        if data.regions.secondRegion == "" {
            regionStackView.removeSecondRegion()
        }
        
        regionStackView.configureRegion(data.regions)
    }
    
    func configureStackView(with certifications: Certifications) {
        let data = [certifications.isHaccp, certifications.isVegan, certifications.isNonGMO]
        
//        self.markStackView = GBStackView(type: .big, data: data)
//        
//        if let markStackView = markStackView {
//            bakeryImage.addSubview(markStackView)
//            markStackView.snp.makeConstraints {
//                $0.top.leading.equalToSuperview().offset(10)
//                $0.size.equalTo(CGSize(width: heightConsideringNotch(68), height: heightConsideringNotch(28)))
//            }
//        }
    }
}
