//
//  TitleCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/13.
//

import UIKit

import SnapKit
import Then

final class TitleCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    private let bakeryImage = UIImageView()
    private let markStackView = MarkStackView()
    private let bakeryNameLabel = UILabel()
    private let breadTypeStackView = BreadTypeStackView()
    private lazy var bookmarkButton = BookmarkButton(configuration: .plain())
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        
        bakeryImage.do {
            $0.backgroundColor = .gbbPoint1
            $0.contentMode = .scaleToFill
        }
        
        markStackView.do {
            $0.spacing = 10
        }
        
        bakeryNameLabel.do {
            $0.basic(text: "건대 초코빵", font: .title1!, color: .gbbGray700!)
            $0.numberOfLines = 0
        }
        
        breadTypeStackView.do {
            $0.backgroundColor = .clear
        }
        
        bookmarkButton.do {
            $0.configuration?.imagePlacement = NSDirectionalRectEdge.top
            $0.configuration?.imagePadding = 4
            $0.configuration?.contentInsets = .zero
        }
    }
    
    private func setLayout() {
        
        contentView.addSubviews(bakeryImage, markStackView, bakeryNameLabel, breadTypeStackView, bookmarkButton)
        
        bakeryImage.snp.makeConstraints {
            $0.height.equalTo(243)
            $0.top.directionalHorizontalEdges.equalToSuperview()
        }
        
        markStackView.snp.makeConstraints {
            $0.top.equalTo(bakeryImage.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(24)
        }
        
        bakeryNameLabel.snp.makeConstraints {
            // TODO: 스택뷰 갯수 카운트해서 0개 되면 remakeConstraints 하는 거 넣기 (정은쓰가 해주기로 함)
            $0.top.equalTo(markStackView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(106)
            // TODO: 가게 이름 길어지면 ...으로 요약하는 거 하기 (가게 이름 2줄도 되는지 확인, ...으로 요약하는 게 맞긴 한가? 아니었던 것 같기도,,)
        }
        
        breadTypeStackView.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.top.equalTo(bakeryNameLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(106)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.top.equalTo(bakeryImage.snp.bottom).offset(30)
            $0.trailing.equalToSuperview().inset(24)
            $0.size.equalTo(34)
        }
    }
}
