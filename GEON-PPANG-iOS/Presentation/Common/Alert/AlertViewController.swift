//
//  CommonAlertViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/08/29.
//

import UIKit

import SnapKit
import Then

final class AlertViewController: BaseViewController {
    
    // MARK: - UI Property
    
    private var alertView: UIView
    
    private let backgroundView = UIView()
    
    // MARK: - Life Cycle
    
    init(alertView: UIView) {
        self.alertView = alertView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animateAlert()
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backgroundView.addSubview(alertView)
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func setUI() {
        
        backgroundView.do {
            $0.backgroundColor = .gbbAlertBackground
        }
    }
    
    // MARK: - Custom Method
    
    private func animateAlert() {
        
        view.addSubview(alertView)
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        alertView.do {
            $0.isHidden = true
        }
        
        modalPresentationStyle = .overFullScreen

        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut) { [weak self] in
            self?.alertView.isHidden = false
        }
    }
    
}
