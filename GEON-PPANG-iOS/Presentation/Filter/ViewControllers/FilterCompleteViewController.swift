//
//  FilterCompleteViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/17.
//

import UIKit

import SnapKit
import Then

final class FilterCompleteViewController: BaseViewController {
    
    // MARK: - Property
    
    private var username =  UserDefaults.standard.string(forKey: "nickname") ?? ""
    
    // MARK: - UI Property
    
    private let navigationBar = CustomNavigationBar()
    private let welcomeLabel = UILabel()
    private let welcomeImageView = UIImageView(image: .welcomeImage)
    private lazy var startButton = CommonButton()
    
    // MARK: - Setting
    
    override func setLayout() {
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        view.addSubview(welcomeImageView)
        welcomeImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(CGFloat().heightConsideringBottomSafeArea(55))
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
    }
    
    override func setUI() {
        navigationBar.do {
            $0.addBackButtonAction(UIAction { _ in
                self.navigationController?.popViewController(animated: true)
            })
        }
        
        welcomeLabel.do {
            $0.font = .title1
            $0.textColor = .gbbGray700
            $0.numberOfLines = 2
            $0.setLineHeight(by: 1.03, with: I18N.Filter.welcomeTitle.insertString(username, at: 0))
        }
        
        startButton.do {
            $0.configureButtonTitle(.start)
            $0.configureButtonUI(.gbbMain2!)
            $0.addActionToCommonButton {
                self.startButtonTapped()
            }
        }
    }
    
    // MARK: - Action Helper
    
    private func startButtonTapped() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewControllerToTabBarController()
    }
    
}
