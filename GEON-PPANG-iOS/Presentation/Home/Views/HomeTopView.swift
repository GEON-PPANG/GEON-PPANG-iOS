//
//  HomeTopView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/09.
//

import UIKit

import SnapKit
import Then

final class HomeTopView: UIView {
    
    // MARK: - Property
    
    var gotoNextView: (() -> Void)?
        
    // MARK: - UI Property
    
    private let titleLabel = UILabel()
    private let searchTextField = SearchTextField()
    private lazy var filterButton = UIButton()
    
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
        titleLabel.do {
            $0.numberOfLines = 2
            $0.textAlignment = .left
            $0.font = .pretendardBold(26)
            $0.basic(font: .pretendardBold(26),
                     color: .gbbGray700!)
        }
        
        searchTextField.do {
            $0.viewType(.home)
            $0.gotoNextView = {
                self.gotoNextView?()
            }
        }
        
        filterButton.do {
            $0.setImage(.homeFilterButton, for: .normal)
        }
    }
    
    private func setLayout() {
        addSubviews(titleLabel, filterButton, searchTextField)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(45)
            $0.leading.equalToSuperview().offset(24)
        }
    
        filterButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 44, height: 48))
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        searchTextField.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(filterButton.snp.top)
            $0.trailing.equalTo(filterButton.snp.leading).offset(-12)
        }
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = "\(title)님\n건빵에 오신걸 환영해요!"
    }
}
