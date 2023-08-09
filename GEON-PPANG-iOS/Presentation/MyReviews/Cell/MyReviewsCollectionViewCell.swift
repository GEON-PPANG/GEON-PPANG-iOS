//
//  MyReviewsCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/19.
//

import UIKit

import Kingfisher
import SnapKit
import Then

final class MyReviewsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    private var breadTypeTag: [String] = []
    
    // MARK: - UI Property
    
    private let markStackView = MarkStackView()
    private let bakeryImage = UIImageView()
    private let bakeryTitle = UILabel()
    private let regionStackView = RegionStackView()
    private lazy var arrowButton = UIButton()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: OptionsCollectionViewFlowLayout())
    
    // MARK: - Life Cycle
    
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
    
    private func setUI() {
        
        self.do {
            $0.contentView.backgroundColor = .white
        }
        
        bakeryImage.do {
            $0.makeCornerRound(radius: 5)
        }
        
        markStackView.do {
            $0.confiureIconImage(.smallHACCPMark, .smallVeganMark, .smallGMOMark)
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
    
    private func setLayout() {
 
        contentView.addSubview(bakeryImage)
        bakeryImage.snp.makeConstraints {
            $0.size.equalTo(90)
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().inset(24)
        }
               
        contentView.addSubview(bakeryTitle)
        bakeryTitle.snp.makeConstraints {
            $0.top.equalTo(bakeryImage.snp.top)
            $0.leading.equalTo(bakeryImage.snp.trailing).offset(14)
        }
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.top.equalTo(bakeryTitle.snp.bottom).offset(8)
            $0.leading.equalTo(bakeryImage.snp.trailing).offset(14)
            $0.trailing.equalToSuperview().inset(27)
        }
        
        contentView.addSubview(regionStackView)
        regionStackView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(10)
            $0.height.equalTo(29)
            $0.leading.equalTo(bakeryImage.snp.trailing).offset(14)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        bakeryImage.addSubview(markStackView)
        markStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(8)
            $0.size.equalTo(CGSize(width: 55, height: 22))
        }
        
    }
    
    func configureCellUI(_ data: MyReviewsResponseDTO) {
        
        bakeryTitle.setLineHeight(by: 1.05, with: data.bakeryName)
        guard let url = URL(string: data.bakeryPicture) else { return }
        bakeryImage.kf.setImage(with: url)
        markStackView.getMarkStatus(data.isHACCP, data.isVegan, data.isNonGMO)
        
        if data.secondNearStation == "" {
            regionStackView.removeSecondRegion()
        }
        regionStackView.configureRegionName(data.firstNearStation, data.secondNearStation ?? "")
        
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

        regionStackView.do {
            $0.configureBackgroundColor(.gbbGray700!)
        }
        
        collectionView.snp.remakeConstraints {
            $0.height.equalTo(Utils.getHeight(breadTypeTag))
            $0.top.equalTo(bakeryTitle.snp.bottom).offset(8)
            $0.leading.equalTo(bakeryImage.snp.trailing).offset(14)
            $0.trailing.equalToSuperview().inset(27)
        }
        
        collectionView.reloadData()
    }
    
}

// MARK: - CollectionView Register

extension MyReviewsCollectionViewCell {
    
    private func setRegistration() {
        collectionView.register(cell: DescriptionCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDataSource

extension MyReviewsCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return breadTypeTag.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DescriptionCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configureTagTitle(self.breadTypeTag[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MyReviewsCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tagTitle = self.breadTypeTag[indexPath.item]
        let itemSize = tagTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.pretendardMedium(13)])
        return CGSize(width: itemSize.width + 12, height: itemSize.height + 8)
    }
}
