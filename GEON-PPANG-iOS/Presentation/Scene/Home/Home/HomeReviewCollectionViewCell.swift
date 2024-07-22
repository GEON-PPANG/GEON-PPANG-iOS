//
//  HomeReviewCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import UIKit

import Kingfisher
import SnapKit

final class HomeReviewCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    private var keywords: [String] = []
    private var reviewList: [HomeBestReviewResponseDTO] = []
    
    // MARK: - UI Property
    
    private lazy var bakeryImage: GradientImageView = {
        let view = GradientImageView(colors: [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.5).cgColor])
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let reviewTitle: UILabel = {
        let label = UILabel()
        label.font = .bodyB2
        label.textColor = .gbbWhite
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let bakeryTitle: UILabel = {
        let label = UILabel()
        label.font = .bodyB1
        label.textColor = .gbbGray700
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: OptionsCollectionViewFlowLayout())
        collectionView.register(DescriptionCollectionViewCell.self, 
                                forCellWithReuseIdentifier: DescriptionCollectionViewCell.identifier)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let reviewCount = IconWithTextView(.reviews)
    private let bookmarkCount = IconWithTextView(.bookmark)
    
    // MARK: - init
    
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
            $0.height.equalTo(heightConsideringNotch(130))
        }
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(bakeryImage.snp.bottom).offset(16)
            $0.directionalHorizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(25)
        }
        
        contentView.addSubview(bakeryTitle)
        bakeryTitle.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(bookmarkCount)
        bookmarkCount.snp.makeConstraints {
            $0.top.equalTo(bakeryTitle.snp.bottom).offset(9)
            $0.bottom.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().offset(16)
        }
        
        contentView.addSubview(reviewCount)
        reviewCount.snp.makeConstraints {
            $0.top.equalTo(bakeryTitle.snp.bottom).offset(9)
            $0.bottom.equalToSuperview().inset(15)
            $0.leading.equalTo(bookmarkCount.snp.trailing).offset(6)
        }
        
        bakeryImage.addSubview(reviewTitle)
        reviewTitle.snp.makeConstraints {
            $0.bottom.equalTo(bakeryImage.snp.bottom).inset(13)
            $0.directionalHorizontalEdges.equalToSuperview().inset(15)
        }
    }
    
    private func setUI() {
        
        self.layer.applyShadow(alpha: 0.1, x: 0, y: 0, blur: 10)
        self.contentView.backgroundColor = .white
        self.contentView.makeCornerRound(radius: 5)
        self.contentView.clipsToBounds = true
    }
    
    func configureCellUI(data: BestReview) {
        
        let url = URL(string: data.overview.image)
        bakeryImage.kf.setImage(with: url, placeholder: UIImage.loading_large)
        
        reviewTitle.setLineHeight(by: 1.14, with: "\"\(data.reviewOverview)\"")
        reviewTitle.lineBreakMode = .byTruncatingTail
        bakeryTitle.setLineHeight(by: 1.08, with: data.overview.name)
        bakeryTitle.lineBreakMode = .byTruncatingTail
        
        reviewCount.configureHomeCell(count: data.reviewCount)
        bookmarkCount.configureHomeCell(count: data.bookmarkCount)
        
        keywords = data.recommendKeywords
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension HomeReviewCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DescriptionCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.cellColor = .basic
        cell.configureTagTitle(self.keywords[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeReviewCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let keywordsTitle = self.keywords[indexPath.item]
        let itemSize = keywordsTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.captionM1!])
        return CGSize(width: itemSize.width + 12, height: itemSize.height + 8)
    }
}
