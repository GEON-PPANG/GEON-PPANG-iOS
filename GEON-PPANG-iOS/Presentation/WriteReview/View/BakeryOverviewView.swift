//
//  BakeryOverviewView.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/06.
//

import UIKit

import SnapKit
import Then

final class BakeryOverviewView: UIView {
    
    // MARK: - Property
    
    private var ingredientsData: [String] = []
    
    // MARK: - UI Property
    
    private let bakeryImageView = UIImageView()
    private let flowLayout = OptionsCollectionViewFlowLayout()
    lazy var bakeryIngredientsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private let sampleView = UIView()
    private let regionStackView = RegionStackView()
    
    // MARK: - Life Cycle
    
    init(bakeryImage: UIImage, ingredients: [String], firstRegion: String, secondRegion: String) {
        super.init(frame: .zero)
        
        setProperties(bakeryImage, ingredients, firstRegion, secondRegion)
        setLayout()
        setUI()
        setDelegate()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setProperties(_ bakeryImage: UIImage, _ ingredients: [String], _ firstRegion: String, _ secondRegion: String) {
        self.bakeryImageView.image = bakeryImage
        self.ingredientsData = ingredients
        if secondRegion == "" {
            regionStackView.removeSecondRegion()
        }
        regionStackView.getRegionName(firstRegion, secondRegion)
        regionStackView.getBackgroundColor(.black)
    }
    
    private func setLayout() {
        self.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(90)
        }
        
        addSubview(bakeryImageView)
        bakeryImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
            $0.width.height.equalTo(90)
        }
        
        addSubview(bakeryIngredientsCollectionView)
        bakeryIngredientsCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(bakeryImageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(20)
        }
        
        addSubview(regionStackView)
        regionStackView.snp.makeConstraints {
            $0.leading.equalTo(bakeryImageView.snp.trailing).offset(20)
            $0.top.equalTo(bakeryIngredientsCollectionView.snp.bottom).offset(16)
        }
    }
    
    private func setUI() {
        bakeryImageView.do {
            // TODO: image 추가 시 적용
            $0.backgroundColor = .gbbPoint1
            $0.makeCornerRound(radius: 5)
            $0.contentMode = .scaleAspectFill
        }
        
        bakeryIngredientsCollectionView.do {
            $0.register(cell: DescriptionCollectionViewCell.self)
        }
    }
    
    private func setDelegate() {
        bakeryIngredientsCollectionView.delegate = self
        bakeryIngredientsCollectionView.dataSource = self
    }
    
}

// MARK: - UICollectionViewDelegate extension

extension BakeryOverviewView: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource extension

extension BakeryOverviewView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredientsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DescriptionCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configureTagTitle(ingredientsData[indexPath.item])
        return cell
    }
    
}

extension BakeryOverviewView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell: DescriptionCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        return cell.fittingSize(availableHeight: 25)
    }
}
