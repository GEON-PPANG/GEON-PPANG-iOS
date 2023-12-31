//
//  SearchResultView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class SearchResultHeaderView: UICollectionReusableView {
    
    // MARK: - UI Property
    
    private let resultLabel = UILabel()
    
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
    
    private func setLayout() {
        
        self.addSubview(resultLabel)
        resultLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
        }
    }
    
    private func setUI() {
        
        resultLabel.do {
            $0.basic(font: .headLine!, color: .gbbGray600!)
            
        }
    }
    
    func configureUI(count: Int) {
        resultLabel.text = "건빵집 결과 \(count)개"
        resultLabel.partColorChange(targetString: "\(count)개", textColor: .gbbPoint1!)
    }
}
