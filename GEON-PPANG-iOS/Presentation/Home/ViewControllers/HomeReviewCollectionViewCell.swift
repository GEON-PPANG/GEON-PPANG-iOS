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
    private var keywords: [String] = []
    private var reviewList: [HomeBestReviewResponseDTO]?
    
    // MARK: - UI Property
    
    private lazy var bakeryImage = GradientImageView(colors: [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.3).cgColor])
    private let reviewTitle = UILabel()
    private let bakeryTitle = UILabel()
    private let bakeryReview = UILabel()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: OptionsCollectionViewFlowLayout())
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
        
        setRegister()
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
            $0.clipsToBounds = true
        }
        
        reviewTitle.do {
            $0.basic(font: .bodyB2!, color: .white)
            $0.numberOfLines = 2
        }
        
        collectionView.do {
            $0.isScrollEnabled = false
            $0.backgroundColor = .clear
            $0.delegate = self
            $0.dataSource = self
        }
        
        bakeryTitle.do {
            $0.basic(font: .bodyB2!, color: .gbbGray700!)
        }
        
        bakeryReview.do {
            $0.basic(font: .pretendardBold(13), color: .gbbGray700!)
        }
        
        [bakeryTitle, bakeryReview].forEach {
            $0.do {
                $0.numberOfLines = 1
                $0.textAlignment = .left
            }
        }
    }
    
    private func setLayout() {
        contentView.addSubviews(bakeryImage, collectionView, bakeryTitle, bakeryReview)
        bakeryImage.addSubview(reviewTitle)
        
        bakeryImage.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(130)
        }
        
        reviewTitle.snp.makeConstraints {
            $0.bottom.equalTo(bakeryImage.snp.bottom).inset(13)
            $0.directionalHorizontalEdges.equalToSuperview().inset(15)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(bakeryImage.snp.bottom).offset(16)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(25)
        }
        
        bakeryTitle.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(16)
        }
        
        bakeryReview.snp.makeConstraints {
            $0.top.equalTo(bakeryTitle.snp.bottom).offset(6)
            $0.bottom.leading.equalToSuperview().inset(16)
        }
        
    }
    
    func updateUI(data: BestReviews, index: Int) {
        self.index = index
        let url = URL(string: data.bakeryPicture)
        bakeryImage.kf.setImage(with: url)
        reviewTitle.text = data.reviewText
        bakeryTitle.text = data.bakeryName
        bakeryReview.text = "리뷰(\(data.reviewCount))"
        bakeryReview.partColorChange(targetString: "\(data.reviewCount)", textColor: .gbbPoint1!)
        
        self.keywords.append(data.firstMaxRecommendKeyword)
        
        if self.reviewList?[index].secondMaxRecommendKeyword != nil {
            self.keywords.append(data.secondMaxRecommendKeyword ?? "" )
        }
    }
}

// MARK: - CollectionView Register

extension HomeReviewCollectionViewCell {
    private func setRegister() {
        collectionView.register(cell: DescriptionCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeReviewCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DescriptionCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configureTagTitle(self.keywords[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeReviewCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let keywordsTitle = self.keywords[indexPath.item]
        let itemSize = keywordsTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.pretendardMedium(13)])
        return CGSize(width: itemSize.width + 12, height: itemSize.height + 8)
    }
}
