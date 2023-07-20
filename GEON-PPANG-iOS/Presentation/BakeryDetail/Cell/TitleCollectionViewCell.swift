//
//  TitleCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/13.
//

import UIKit

import Kingfisher
import SnapKit
import Then

final class TitleCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private let bakeryImage = UIImageView()
    private lazy var markStackView = MarkStackView()
    private let bakeryNameLabel = UILabel()
    private lazy var breadTypeStackView = BreadTypeStackView()
    private lazy var bookmarkReviewStackView = BookmarkReviewNumberStackView()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        
        self.backgroundColor = .gbbWhite
        
        bakeryImage.do {
            $0.contentMode = .scaleToFill
        }
        
        markStackView.do {
            $0.setMarkSize(28)
            $0.spacing = 10
        }
        
        bakeryNameLabel.do {
            $0.basic(font: .title1!, color: .gbbGray700!)
            $0.adjustsFontSizeToFitWidth = true
        }
        
        breadTypeStackView.do {
            $0.getChipStatus(false, false, false, false)
        }
    }
    
    private func setLayout() {
        
        contentView.addSubviews(bakeryImage, markStackView, bakeryNameLabel, breadTypeStackView, bookmarkReviewStackView)
        
        bakeryImage.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(243)
        }
        
        markStackView.snp.makeConstraints {
            $0.top.equalTo(bakeryImage.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(24)
        }
        
        bakeryNameLabel.snp.makeConstraints {
            $0.top.equalTo(markStackView.snp.bottom).offset(16)
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(32)
        }
        
        breadTypeStackView.snp.makeConstraints {
            $0.top.equalTo(bakeryNameLabel.snp.bottom).offset(12)
            $0.leading.equalTo(bakeryNameLabel)
        }
        
        // TODO: 통신 전 쓰레기 값 hidden 시키기
        bookmarkReviewStackView.snp.makeConstraints {
            $0.top.equalTo(breadTypeStackView.snp.bottom).offset(16)
            $0.leading.equalTo(breadTypeStackView)
        }
    }
    
    func updateUI(_ data: BakeryDetailResponseDTO) {
        
        guard let url = URL(string: data.bakeryPicture) else { return }
        bakeryImage.kf.setImage(with: url)
        bakeryNameLabel.text = data.bakeryName
        markStackView.getMarkStatus(data.isHACCP, data.isVegan, data.isNonGMO)
        
        if !data.isHACCP && !data.isVegan && !data.isNonGMO {
            bakeryNameLabel.snp.remakeConstraints {
                $0.top.equalTo(bakeryImage.snp.bottom).offset(30)
                $0.directionalHorizontalEdges.equalToSuperview().inset(24)
                $0.height.equalTo(32)
            }
        }
        breadTypeStackView.getChipStatus(data.breadType.isGlutenFree, data.breadType.isVegan, data.breadType.isNutFree, data.breadType.isSugarFree)
        bookmarkReviewStackView.updateCount(bookmarkCount: data.bookMarkCount, reviewCount: data.reviewCount)
    }
}
