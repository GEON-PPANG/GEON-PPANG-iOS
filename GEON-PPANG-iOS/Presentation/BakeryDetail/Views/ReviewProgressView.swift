//
//  ReviewProgressView.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class ReviewProgressView: UIView {
    
    // MARK: - Property
    
    // 회전할 각도 설정
    private let rotationAngle: CGFloat = .pi / -2 // 90도 반시계 방향 회전
    
    private var time: Float = 0.0 // 애니메이션 지속 시간 커스텀을 위한 변수 선언
    private var timer: Timer?
    
    // TODO: reviewCount = eachKeywordCount - totalReviewCount
    var gauge: Float = 1
    
    // 진행 바를 수직으로 회전
    
    // MARK: - UI Property
    
    private let reviewProgressBar = UIProgressView()
    let reviewLabel = UILabel()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
        setLayout()
        setProgressBar()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        
        reviewProgressBar.do {
            $0.progress = 0
            $0.trackTintColor = .gbbBackground2
            $0.progressTintColor = .gbbMain3
            $0.progressViewStyle = .default
            $0.transform = CGAffineTransform(rotationAngle: rotationAngle)
            $0.makeCornerRound(radius: 4)
        }
        
        reviewLabel.do {
            $0.basic(text: "맛있어요", font: .captionB1!, color: .gbbMain2!)
            $0.textAlignment = .center
            $0.numberOfLines = 1
        }
    }
    
    private func setLayout() {
        
        self.addSubviews(reviewProgressBar, reviewLabel)
        self.backgroundColor = .gbbWhite
        
        reviewProgressBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(47)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(102)
            $0.height.equalTo(8)
        }
        
        reviewLabel.snp.makeConstraints {
            $0.top.equalTo(reviewProgressBar.snp.bottom).offset(63.25)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(17)
        }
    }
    
    // MARK: - Custom Method
    
    @objc private func setProgressBarAnimation() {
        
        time += gauge / 20
        reviewProgressBar.setProgress(time, animated: true)
        
        if time >= gauge {
            timer!.invalidate()
        }
    }
    
    private func setProgressBar() {
        
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(setProgressBarAnimation), userInfo: nil, repeats: true)
    }
}
