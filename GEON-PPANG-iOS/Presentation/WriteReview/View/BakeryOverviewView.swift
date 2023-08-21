//
//  BakeryOverviewView.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/06.
//

import UIKit

import Kingfisher
import SnapKit
import Then

final class BakeryOverviewView: UIView {
    
    // MARK: - Property
    
    private let data: SimpleBakeryModel
    
    // MARK: - UI Property
    
    private let bakeryImageView = UIImageView()
    private let bakeryNameLabel = UILabel()
    private let flowLayout = OptionsCollectionViewFlowLayout()
    lazy var bakeryIngredientsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private var bookmarkCountLabel = BookmarkCountLabel(count: 23)
    private var regionLabel: RegionLabel?
    
    // MARK: - Life Cycle
    
    init(of bakery: SimpleBakeryModel) {
        self.data = bakery
        
        super.init(frame: .zero)
        
        setProperties()
        setLayout()
        setUI()
        setDelegate()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setProperties() {
        
        var regions = data.bakeryRegion
        if !regions.isEmpty {
            self.regionLabel = RegionLabel(regions.removeFirst(),
                                           regions.removeFirst())
        }
    }
    
    private func setLayout() {
        
        self.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(90)
        }
        
        self.addSubview(bakeryImageView)
        bakeryImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(86)
        }
        
        self.addSubview(bakeryNameLabel)
        bakeryNameLabel.snp.makeConstraints {
            $0.top.equalTo(bakeryImageView)
            $0.leading.equalTo(bakeryImageView.snp.trailing).offset(8)
        }
        
        self.addSubview(bookmarkCountLabel)
        bookmarkCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(bakeryNameLabel)
        }
        
        self.addSubview(bakeryIngredientsCollectionView)
        bakeryIngredientsCollectionView.snp.makeConstraints {
            $0.top.equalTo(bakeryNameLabel.snp.bottom).offset(9)
            $0.leading.equalTo(bakeryNameLabel)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(22)
        }
        
        guard let regionLabel = self.regionLabel else { return }
        self.addSubview(regionLabel)
        regionLabel.snp.makeConstraints {
            $0.leading.equalTo(bakeryNameLabel)
            $0.bottom.equalTo(bakeryImageView).offset(-2)
        }
    }
    
    private func setUI() {
        
        bakeryImageView.do {
            $0.kf.setImage(with: URL(string: data.bakeryImageURL))
            $0.backgroundColor = .gbbPoint1
            $0.makeCornerRound(radius: 5)
            $0.contentMode = .scaleAspectFill
        }
        
        bakeryNameLabel.do {
            $0.setLineHeight(by: 1.05, with: data.bakeryName)
            $0.textColor = .gbbGray700
            $0.font = .title2
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
        
        return data.bakeryIngredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: DescriptionCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.cellColor = .sub
        cell.configureTagTitle(data.bakeryIngredients[indexPath.item])
        return cell
    }
    
}

extension BakeryOverviewView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cell: DescriptionCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        return cell.fittingSize(availableHeight: 22)
    }
}
