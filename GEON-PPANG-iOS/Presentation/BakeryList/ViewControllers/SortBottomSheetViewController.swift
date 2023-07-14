//
//  SortBottomSheetViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/15.
//

import UIKit

import SnapKit
import Then

final class SortBottomSheetViewController: BaseViewController {
    
    // MARK: - Property
    
    private let bottomSheetHeight: CGFloat = 155
    
    // MARK: - UI Property
    
    private let dimmedView = UIView()
    private let bottomSheetView = UIView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDimmedViewTapGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBottomSheet()
    }
    
    // MARK: - Setting
    
    override func setLayout() {
        view.addSubview(dimmedView)
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(bottomSheetView)
        bottomSheetView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(0)
        }
    }
    
    override func setUI() {
        view.do {
            $0.backgroundColor = .clear
        }
        
//        dimmedView.do {
//            $0.backgroundColor = .black.withAlphaComponent(0.4)
//        }
        
        bottomSheetView.do {
            $0.backgroundColor = .gbbWhite
            $0.layer.cornerRadius = 12
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            $0.clipsToBounds = true
        }
    }
    
    private func setDimmedViewTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedView.addGestureRecognizer(tapGesture)
        dimmedView.isUserInteractionEnabled = true
    }
    
    private func showBottomSheet() {
        UIView.animate(withDuration: 0.2) {
            self.dimmedView.do {
                $0.backgroundColor = .black.withAlphaComponent(0.4)
            }
            
            self.bottomSheetView.snp.updateConstraints {
                $0.height.equalTo(self.bottomSheetHeight)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Action Helper
    
    @objc
    private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheet()
    }
    
    // MARK: - Custom Method
    
    private func hideBottomSheet() {
        UIView.animate(withDuration: 0.2) {
            self.dimmedView.do {
                $0.backgroundColor = .black.withAlphaComponent(0.0)
            }
            
            self.bottomSheetView.snp.makeConstraints {
                $0.height.equalTo(0)
            }
            
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    
}
