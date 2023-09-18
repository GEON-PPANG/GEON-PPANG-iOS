//
//  RadioButton.swift
//  GEON-PPANG-iOS
//
//  Created by kyun on 2023/09/17.
//

import UIKit

import SnapKit
import Then

final class RadioButton: UIButton {
    
    // MARK: - UI Property
    
    private lazy var radioButton = UIButton()
    private let radioButtonImage = UIImageView(image: .logoIcon16px)
    private let radioButtonLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.addSubview(radioButton)
        radioButton.snp.makeConstraints {
            
        }
    }
    
    private func setUI() {
        
    }
}
