//
//  BottomSheetAppearView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class BottomSheetAppearView: UIView {
    
    // MARK: - UI Property
    
    static let shared = BottomSheetAppearView()
    private var customAction: (() -> Void)?
    var dimmedViewInteraction: Bool = true
    
    var addedSubView = UIView()
    lazy var dimmedView = UIView()
    private lazy var halfView =  UIView()
    private lazy var handlerView = UIView()
    
    // MARK: - Setting
    
    private func setUI() {
        dimmedView.do {
            $0.backgroundColor = .black.withAlphaComponent(0.6)
            if self.dimmedViewInteraction {
                $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss)))
            }
        }
        
        halfView.do {
            $0.backgroundColor = .white
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            $0.makeCornerRound(radius: 10)
        }
        
        handlerView.do {
            $0.backgroundColor = .gbbGray200
            $0.makeCornerRound(radius: 4)
        }
    }
}

extension BottomSheetAppearView {
    
    func initializeMainView(_ halfViewHeight: CGFloat? = nil) {
        
        if let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) {
            window.endEditing(true)
            dimmedView.frame = window.frame
            window.addSubviews(dimmedView, halfView)
            halfView.addSubview(handlerView)
            setUI()
            
            halfView.snp.remakeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                if let height = halfViewHeight {
                    $0.height.equalTo(height)
                } else {
                    $0.height.equalTo(dimmedView.frame.size.height / 2.0)
                }
            }
            handlerView.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().offset(8)
                $0.size.equalTo(CGSize(width: 60, height: 6))
            }
        }
    }
    
    @objc
    func dismiss(gesture: UITapGestureRecognizer?) {
        
        dissmissFromSuperview()
    }
    
    func dissmissFromSuperview() {
        
        if UIApplication.shared.windows.first(where: { $0.isKeyWindow }) != nil {
            let transform = CGAffineTransform(translationX: 0, y: 200)
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: .curveEaseOut,
                animations: { [unowned self] in
                    self.halfView.transform = transform
                    self.halfView.alpha = 0
                    self.dimmedView.alpha = 0
                },
                completion: { _ in
                    self.addedSubView.removeFromSuperview()
                    self.dimmedView.removeFromSuperview()
                    self.halfView.removeFromSuperview()
                }
            )
        }
    }
}

extension BottomSheetAppearView {
    
    func appearBottomSheetView(subView: UIView, _ halfViewHeight: CGFloat? = nil) {
        
        initializeMainView(halfViewHeight)
        addedSubView = subView
        halfView.addSubview(addedSubView)
        
        addedSubView.snp.makeConstraints {
            $0.top.equalTo(handlerView.snp.bottom)
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
        }
        
        if UIApplication.shared.windows.first(where: { $0.isKeyWindow }) != nil {
            let transform = CGAffineTransform(translationX: 0, y: 300)
            halfView.transform = transform
            dimmedView.alpha = 0
            UIView.animate(
                withDuration: 0.4,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: .curveEaseOut,
                animations: {
                    self.dimmedView.alpha = 0.5
                    self.halfView.alpha = 1
                    self.halfView.transform = .identity
                },
                completion: nil)
        }
    }
}
