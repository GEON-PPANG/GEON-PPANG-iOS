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
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
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
            $0.configureIconImage(.smallHACCPMark, .smallVeganMark, .smallGMOMark)
        }
        
        bakeryTitle.do {
            $0.basic(font: .title2!, color: .gbbGray700!)
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
        
        bakeryTitle.setLineHeight(by: 1.05, with: data.name)
        bakeryTitle.lineBreakMode = .byTruncatingTail
        bookmarkCount.configureHomeCell(count: data.bookmarkCount)
        bookmarkCount.setContentHuggingPriority(UILayoutPriority(751), for: .horizontal)
        bookmarkCount.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        
        guard let url = URL(string: data.picture) else { return }
        bakeryImage.kf.setImage(with: url)
        
        regionStackView.configureListUI(text: data.station)
        markStackView.getMarkStatus(data.mark.isHACCP, data.mark.isVegan, data.mark.isNonGMO)
        
        breadTypeTag = []
        if data.breadType.isGlutenFree {
            breadTypeTag.append(I18N.BakeryList.glutenfree)
        }
        
        if data.breadType.isNutFree {
            breadTypeTag.append(I18N.BakeryList.nutfree)
        }
        
        if data.breadType.isVegan {
            breadTypeTag.append(I18N.BakeryList.vegan)
        }
        
        if data.breadType.isSugarFree {
            breadTypeTag.append(I18N.BakeryList.noSugar)
        }
        
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
        
        let tagTitle = self.breadTypeTag[indexPath.item]
        let itemSize = tagTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.captionM2])
        return CGSize(width: itemSize.width + 12, height: itemSize.height)
    }
}
