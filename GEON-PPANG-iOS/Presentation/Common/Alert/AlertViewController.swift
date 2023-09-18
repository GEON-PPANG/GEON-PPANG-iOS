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
    
    // MARK: - Life Cycle
    
    init(alertView: UIView) {
        self.alertView = alertView
        
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setAlertAction()
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animateAlert()
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        
        view.addSubview(alertView)
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
    }
    
    override func setUI() {
        
        view.do {
            $0.backgroundColor = .gbbAlertBackground
        }
    }
    
    func configureAlertAction(_ acceptAction: (() -> Void)?) {
        
        guard let alert = alertView as? AlertView
        else { return }
        
        alert.cancelAction = { [weak self] in
            self?.dismiss(animated: true)
            print("cancel tapped")
        }
        alert.acceptAction = acceptAction
//        { [weak self] in
//            // TODO: API 연결
//            switch alert.alertType {
//            case .logout: print("logout API")
//            case .leave: print("leave API")
//            }
//            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
//            sceneDelegate?.changeRootViewControllerToOnboardingViewController()
//            print("accept tapped")
//        }
    }
    
    // MARK: - Custom Method
    
    private func animateAlert() {
        
        view.addSubview(alertView)
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}
