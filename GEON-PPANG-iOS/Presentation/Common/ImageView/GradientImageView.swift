//
//  GradientImageView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/11.
//

import UIKit

final class GradientImageView: UIImageView {
    
    // MARK: - Property
    
    private let gradient: CAGradientLayer = CAGradientLayer()
    
    // MARK: - Life Cycle
    
    init(colors: [CGColor]) {
        super.init(frame: .zero)
        
        setGradient(colors: colors)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    func setGradient(colors: [CGColor]) {
        gradient.colors = colors
        gradient.locations = [0, 1.0]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        layer.addSublayer(gradient)
    }
    
    func setLayout() {
        gradient.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)
        gradient.frame = bounds
    }
}
