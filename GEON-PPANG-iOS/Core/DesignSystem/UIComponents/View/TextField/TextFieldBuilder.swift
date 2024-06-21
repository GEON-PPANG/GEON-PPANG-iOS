//
//  TextFieldBuilder.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 6/14/24.
//

import UIKit
import SnapKit

// search, textfiled

final class TextFieldBuilder: UITextField {
    
    private let leftButton: UIButton
    private let rightButton: UIButton
    private var insets: UIEdgeInsets
    private var rightViewRect: UIEdgeInsets
    private var leftViewRect: UIEdgeInsets
    
    init() {
        self.leftButton = UIButton()
        self.rightButton = UIButton()
        self.insets = UIEdgeInsets()
        self.rightViewRect = UIEdgeInsets()
        self.leftViewRect = UIEdgeInsets()
        super.init(frame: .zero)
        
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.leftButton.isEnabled = false
        self.placeholder = "빵집·지역·역 명을 검색해 보세요!"
        self.layer.masksToBounds = true
        self.layer.cornerRadius = CGFloat().convertByHeightRatio(22)
        self.backgroundColor = .gbbGray100
    }

    func build() -> UITextField {
        return self
    }
}

extension TextFieldBuilder {
    
    func setClearAction() -> TextFieldBuilder {
        let action = UIAction { _ in self.text = "" }
        self.rightButton.addAction(action, for: .touchUpInside)
        return self
    }
    
    func setRect(forInsets insets: UIEdgeInsets) -> TextFieldBuilder {
        self.insets = insets
        return self
    }
    
    func setLeftView(to image: UIImage, mode: UITextField.ViewMode) -> TextFieldBuilder {
        self.leftButton.setImage(image, for: .normal)
        self.leftView = self.leftButton
        self.leftViewMode = mode
        return self
    }
    
    func setLeftViewRect(forInsets insets: UIEdgeInsets) -> TextFieldBuilder {
        self.leftViewRect = insets
        return self
    }
    
    func setRightView(to image: UIImage, mode: UITextField.ViewMode) -> TextFieldBuilder {
        self.rightButton.setImage(image, for: .normal)
        self.rightView = self.rightButton
        self.rightViewMode = mode
        return self
    }
    
    func setRightView(to view: UIButton) -> TextFieldBuilder {
        self.rightView = view
        self.rightViewMode = .always
        return self
    }
    
    func setRightViewRect(forInsets insets: UIEdgeInsets) -> TextFieldBuilder {
        self.rightViewRect = insets
        return self
    }
}

// MARK: - TextField Rect

extension TextFieldBuilder {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: self.insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: self.insets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: self.insets)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.rightViewRect(forBounds: bounds)
        return rect.inset(by: self.rightViewRect)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.leftViewRect(forBounds: bounds)
        return rect.inset(by: self.leftViewRect)
    }
}
