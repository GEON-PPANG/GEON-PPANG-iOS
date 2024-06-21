//
//  BakeryListCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/11.
//

import UIKit

import Kingfisher
import SnapKit
import Then

final class BakeryCommonCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    private var breadTypeTag: [String] = []
    private var ingredientList: [BakeryCommonListResponseDTO] = []
    private var itemSizeCache: [Int: CGSize] = [:]

    // MARK: - UI Property
    
    private let markStackView = MarkStackView()
    private let bakeryImage = UIImageView()
    private let bakeryTitle = UILabel()
    private let regionStackView = IconWithTextView(.region)
    private let bookmarkCount = IconWithTextView(.bookmark)
    private lazy var arrowButton = UIButton()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: OptionsCollectionViewFlowLayout())
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ingredientList = []
        bakeryImage.kf.cancelDownloadTask()
        bakeryImage.image = nil
        itemSizeCache.removeAll()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setUI()
        setRegistration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        contentView.addSubview(bakeryImage)
        bakeryImage.snp.makeConstraints {
            $0.size.equalTo(86)
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        contentView.addSubview(bookmarkCount)
        bookmarkCount.snp.makeConstraints {
            $0.top.equalTo(bakeryImage.snp.top).offset(4)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        contentView.addSubview(bakeryTitle)
        bakeryTitle.snp.makeConstraints {
            $0.top.equalTo(bakeryImage.snp.top)
            $0.leading.equalTo(bakeryImage.snp.trailing).offset(8)
            $0.trailing.equalTo(bookmarkCount.snp.leading).offset(-24)
        }
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.top.equalTo(bakeryTitle.snp.bottom).offset(9)
            $0.leading.equalTo(bakeryImage.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        contentView.addSubview(regionStackView)
        regionStackView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(12)
            $0.height.equalTo(15)
            $0.leading.equalTo(bakeryImage.snp.trailing).offset(11)
        }
        
        bakeryImage.addSubview(markStackView)
        markStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(8)
            $0.size.equalTo(CGSize(width: 55, height: 22))
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.contentView.backgroundColor = .white
        }
        
        bakeryImage.do {
            $0.makeCornerRound(radius: 5)
        }
        
        markStackView.do {
            $0.configureIconImage(.haccpMark22px, .veganMark22px, .gmoMark22px)
        }
        
        bakeryTitle.do {
            $0.basic(font: .title2, color: .gbbGray700)
        }
        
        collectionView.do {
            $0.isScrollEnabled = false
            $0.backgroundColor = .clear
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    func configureReviewsUI() {
        bookmarkCount.removeFromSuperview()
    }
    
    func configureCellUI<T: BakeryListProtocol>(data: T) {
     
        bookmarkCount.configureHomeCell(count: data.bookmarkCount)
        bookmarkCount.setContentHuggingPriority(UILayoutPriority(751), for: .horizontal)
        bookmarkCount.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        
        setupCellUI(name: data.name,
                    pictureURL: data.picture,
                    station: data.station,
                    isHACCP: data.isHACCP,
                    isVegan: data.isVegan,
                    isNonGMO: data.isNonGMO,
                    breadTypeList: data.breadTypeList)
    }
    
    func configureCellUI(data: MyReviewsResponseDTO) {
        setupCellUI(name: data.name,
                    pictureURL: data.picture,
                    station: data.station,
                    isHACCP: data.isHACCP, 
                    isVegan: data.isVegan,
                    isNonGMO: data.isNonGMO,
                    breadTypeList: data.breadTypeList)
    }
    
    private func setupCellUI(name: String, pictureURL: String, station: String, isHACCP: Bool, isVegan: Bool, isNonGMO: Bool, breadTypeList: [OldBreadType]) {
        bakeryTitle.setLineHeight(by: 1.05, with: name)
        bakeryTitle.lineBreakMode = .byTruncatingTail
        
        guard let url = URL(string: pictureURL) else { return }
        bakeryImage.kf.setImage(
            with: url,
            placeholder: UIImage.imgLoadingSmall,
            options: [
                .processor(DownsamplingImageProcessor(size: CGSize(width: 86, height: 86))),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
        
        regionStackView.configureListUI(text: station)
        markStackView.getMarkStatus(isHACCP, isVegan, isNonGMO)
        
        breadTypeTag = breadTypeList.map { $0.toString() }
        itemSizeCache.removeAll()
        collectionView.reloadData()
    }
}

// MARK: - CollectionView Register

extension BakeryCommonCollectionViewCell {
    private func setRegistration() {
        collectionView.register(cell: DescriptionCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDataSource

extension BakeryCommonCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return breadTypeTag.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DescriptionCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.cellColor = .sub
        cell.configureTagTitle(self.breadTypeTag[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BakeryCommonCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tagTitle = breadTypeTag[indexPath.item]
        
        guard let cachedSize = itemSizeCache[tagTitle.count] else {
            let itemSize = tagTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.captionM2])
            let finalSize = CGSize(width: itemSize.width + 12, height: itemSize.height)
            itemSizeCache[tagTitle.count] = finalSize
            return finalSize
        }
        
        return cachedSize
    }
}
