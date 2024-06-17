//
//  SignUpBuilder.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 6/14/24.
//

import UIKit
import SnapKit

final class SignUpBuilder: Builder {
    
    private let view: UIView
    private let subView: UIView
    private let titleLabel: UILabel
    private let subLabel: UILabel
    private let textField: UITextField
    
    init(_ textField: UITextField) {
        self.view = UIView()
        self.subView = UIView()
        self.titleLabel = UILabel()
        self.subLabel = UILabel()
        self.textField = textField
        setLayout()
        setUI()
    }
    
    func build() -> UIView {
        return self.view
    }
    
    private func setLayout() {
        self.view.addSubview(subView)
        self.subView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(74)
        }
        
        self.subView.addSubview(titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(subView.snp.top).inset(12)
            $0.leading.equalTo(subView.snp.leading).inset(18)
        }
        
        self.subView.addSubview(textField)
        self.textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(view.snp.trailing).inset(18)
            $0.bottom.equalTo(subView.snp.bottom).inset(12)
        }
        
        self.view.addSubview(subLabel)
        self.subLabel.snp.makeConstraints {
            $0.top.equalTo(subView.snp.bottom).inset(-4)
            $0.trailing.equalTo(subView.snp.trailing)
        }
    }
    
    private func setUI() {
        self.titleLabel.font = .bodyB2
        self.subLabel.font = .captionM1
        
        self.titleLabel.textColor = .gbbGray400
        self.subLabel.textColor = .gbbError
        
        self.subView.makeCornerRound(radius: 12)
        self.subView.backgroundColor = .gbbBackground2
        self.view.backgroundColor = .clear
    }
}

extension SignUpBuilder {
    func setText(to text: String) -> SignUpBuilder {
        self.titleLabel.text = text
        return self
    }
}

import Combine

extension UITextField {
    
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: self
        )
        .compactMap { $0.object as? UITextField }
        .map { $0.text ?? "" }
        .eraseToAnyPublisher()
    }
}

final class DuplicatedButton: UIButton {
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .gbbMain3
        configuration.baseForegroundColor = .gbbWhite
        configuration.cornerStyle = .capsule
        configuration.attributedTitle = AttributedString("중복확인",
                                                         attributes: AttributeContainer([.font: UIFont.captionM1]))
        configuration.contentInsets = .init(top: 10,
                                            leading: 10,
                                            bottom: 10,
                                            trailing: 10)
        
        self.configuration = configuration
    }
}
