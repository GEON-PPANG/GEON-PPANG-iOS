//
//  HomeFooterView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import UIKit

final class HomeFooterView: UICollectionReusableView {
    
    private let footerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        footerLabel.do {
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.basic(font: .pretendardMedium(11), color: .gbbGray300!)
            $0.text =
"""
 건빵은 건강한 빵집의 위치와 성분 정보를 제공하여 소비자의 선택을 돕는 용도의 서비스입니다. 건빵의 모든 정보는 제조사에서 제공한 정보입니다. 이는 소비자의 구매를 돕기 위한 참고 사항이며, 제공 정보의 오류에 대한 책임을 지지 않습니다.
"""
        }
    }
    
    private func setLayout() {
        addSubview(footerLabel)
        
        footerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.directionalHorizontalEdges.equalToSuperview()
        }
    }
}
