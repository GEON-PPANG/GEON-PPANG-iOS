//
//  BakeryDetailTopCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/13.
//

import UIKit

import SnapKit
import Then

final class BakeryDetailTopCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private let bakeryImage = UIImageView()
    private let markStackView = MarkStackView()
    private let bakeryTitleLabel = UILabel()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: OptionsCollectionViewFlowLayout())
    private lazy var bookmarkButton = BookmarkButton(configuration: .plain())
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        
        bakeryImage.do {
            $0.backgroundColor = .gbbError
            $0.contentMode = .scaleAspectFit
        }
        
        markStackView.do {
            $0.spacing = 10
        }
        
        bakeryTitleLabel.do {
            $0.basic(text: "건대 초코빵",font: .title1!, color: .gbbGray700!)
            $0.numberOfLines = 0
        }
        
        collectionView.do {
            $0.isScrollEnabled = false
            $0.backgroundColor = .clear
//            $0.delegate = self
//            $0.dataSource = self
        }
        
        bookmarkButton.do {
            $0.configuration?.imagePlacement = NSDirectionalRectEdge.top
            $0.configuration?.imagePadding = 4
            $0.configuration?.contentInsets = .zero
        }
    }
    
    private func setLayout() {
        
        contentView.addSubviews(bakeryImage, markStackView, bakeryTitleLabel, collectionView, bookmarkButton)
        
        let availableHeight = contentView.bounds.height
        let bakeryImageHeight = 243
        let buttonHeight = 57
        let buttonTopOffset = (Int(availableHeight) + bakeryImageHeight - buttonHeight) / 2
        
        bakeryImage.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(243)
        }
        
        markStackView.snp.makeConstraints {
            $0.top.equalTo(bakeryImage.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(24)
        }
        
        bakeryTitleLabel.snp.makeConstraints {
            // TODO: 스택뷰 갯수 카운트해서 0개 되면 remakeConstraints 하는 거 넣기 (정은쓰가 해주기로 함)
            $0.top.equalTo(markStackView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(106)
        }
        
        collectionView.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.top.equalTo(bakeryTitleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(106)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(buttonTopOffset)
            $0.trailing.equalToSuperview().inset(24)
            $0.size.equalTo(34)
        }
    }
}

extension BakeryDetailTopCollectionViewCell {
    private func setRegister() {
        collectionView.register(cell: DescriptionCollectionViewCell.self)
    }
}
