//
//  WelcomeViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/08/23.
//

import UIKit

import SnapKit
import Then

final class WelcomeViewController: BaseViewController {
    
    // MARK: - Property
    
    let nickname: String
    
    // MARK: - UI Property
    
    private let welcomeLabel = UILabel()
    private let welcomeImageView = UIImageView(image: .Image.welcome)
    
    // MARK: - Life Cycle
    
    init(nickname: String) {
        self.nickname = nickname
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        moveToFilterView()
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(CGFloat().heightConsideringNotch(146))
            $0.leading.equalToSuperview().inset(24)
        }
        
        view.addSubview(welcomeImageView)
        welcomeImageView.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(136)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func setUI() {
        
        welcomeLabel.do {
            $0.font = .title1
            $0.textColor = .gbbGray700
            $0.numberOfLines = 2
            $0.setLineHeight(by: 1.12, with: nickname + I18N.Welcome.welcomeText)
        }
    }
    
    // MARK: - Custom Method
    
    private func moveToFilterView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            Utils.push(self.navigationController, FilterViewController(from: .onboarding))
            AnalyticManager.log(event: .onboarding(.startFilterOnboarding))
        }
    }
    
}
