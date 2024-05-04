//
//  MarkStackView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class MarkStackView: UIStackView {
    
    // MARK: - UI Property
    
    private lazy var haccpMarkIconView = UIImageView()
    private lazy var veganIconView = UIImageView()
    private lazy var gmoIconView = UIImageView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
        setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        [haccpMarkIconView, veganIconView, gmoIconView].forEach {
            $0.snp.makeConstraints {
                $0.size.equalTo(24)
            }
        }
    }
    
    private func setUI() {
        
        self.do {
            $0.addArrangedSubviews(haccpMarkIconView, veganIconView, gmoIconView)
            $0.spacing = -8
            $0.axis = .horizontal
        }
        
        [haccpMarkIconView, veganIconView, gmoIconView].forEach {
            $0.contentMode = .topLeft
        }
    }
    
    func configureIconImage(_ haccp: UIImage,
                            _ vegan: UIImage,
                            _ gmo: UIImage) {
        
        haccpMarkIconView.image = haccp
        veganIconView.image = vegan
        gmoIconView.image = gmo
    }
    
    func configureIconImage(with data: CertificationMarkResponseType) {
        
        haccpMarkIconView.image = data.isHACCP ? .HACCP.mark22 : nil
        veganIconView.image = data.isVegan ? .Vegan.mark22 : nil
        gmoIconView.image = data.isNonGMO ? .GMO.mark22 : nil
        
        haccpMarkIconView.isHidden = data.isHACCP ? false : true
        veganIconView.isHidden = data.isVegan ? false : true
        gmoIconView.isHidden = data.isNonGMO ? false : true
    }
    
    func getMarkStatus(_ isHACCP: Bool,
                       _ isVegan: Bool,
                       _ isNONGMO: Bool) {
        
        haccpMarkIconView.isHidden = !isHACCP
        veganIconView.isHidden = !isVegan
        gmoIconView.isHidden = !isNONGMO
    }
    
    func configureMarkSize(_ size: Int) {
        
        [haccpMarkIconView, veganIconView, gmoIconView].forEach {
            $0.snp.remakeConstraints {
                $0.size.equalTo(size)
            }
        }
    }
}
