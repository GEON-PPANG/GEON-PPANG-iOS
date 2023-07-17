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
    
    private let bakeryImage = UIImageView() // 서버
    private lazy var markStackView = MarkStackView() // 서버
    private let bakeryNameLabel = UILabel() // 서버
    private lazy var breadTypeStackView = BreadTypeStackView() // 서버
    private lazy var bookmarkReviewStackView = BookmarkReviewStackView() // 서버
    
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
    }
    
    private func setLayout() {
        
        contentView.addSubviews(bakeryImage, markStackView, bakeryNameLabel, breadTypeStackView, bookmarkReviewStackView)
        
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
            $0.leading.trailing.equalToSuperview().inset(24)
            // TODO: 가게 이름 길어졌을 때 높이 동적으로 되는지 확인
        }
        
        breadTypeStackView.snp.makeConstraints {
            $0.top.equalTo(bakeryNameLabel.snp.bottom).offset(12)
            $0.leading.equalTo(bakeryNameLabel)
        }
        
        bookmarkReviewStackView.snp.makeConstraints {
            $0.top.equalTo(breadTypeStackView.snp.bottom).offset(16)
            $0.leading.equalTo(breadTypeStackView)
        }
    }
}
