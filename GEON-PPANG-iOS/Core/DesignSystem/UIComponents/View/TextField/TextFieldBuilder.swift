//
//  TextFieldBuilder.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 6/14/24.
//

import UIKit
import SnapKit

import Combine

// search, textfiled

final class TextFieldBuilder: UITextField {
    
    private let leftButton: UIButton
    private let rightButton: UIButton
    private var insets: UIEdgeInsets
    private var rightViewRect: UIEdgeInsets
    private var leftViewRect: UIEdgeInsets
    
    private var cancellables = Set<AnyCancellable>()
    private var rightButtonTapSubject = PassthroughSubject<Void, Never>()
    
    init() {
        self.leftButton = UIButton()
        self.rightButton = UIButton()
        self.insets = UIEdgeInsets()
        self.rightViewRect = UIEdgeInsets()
        self.leftViewRect = UIEdgeInsets()
        super.init(frame: .zero)
        self.setUI()
        self.setBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.leftButton.isEnabled = false
    }
    
    private func setBindings() {
        self.rightButton.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.rightButtonTapSubject.send()
            }
            .store(in: &cancellables)
    }
    
    func build() -> UITextField {
        return self
    }
}

extension TextFieldBuilder {

    func setDescription(to text: String) -> TextFieldBuilder {
        self.placeholder = text
        return self
    }
    
    func setPlaceholder(to color: UIColor, to font: UIFont ) -> TextFieldBuilder {
        self.setPlaceholder(color: color, font: font)
        return self
    }
    
    func setCornerRadius(to amount: CGFloat) -> TextFieldBuilder {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = amount
        return self
    }
    
    func setBackgroundColor(to color: UIColor) -> TextFieldBuilder {
        self.backgroundColor = color
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
    
    func setSecureTextEntry(to secure: Bool) -> TextFieldBuilder {
        self.isSecureTextEntry = secure
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
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: self.insets)
    }
    
    override public func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.rightViewRect(forBounds: bounds)
        return rect.inset(by: self.rightViewRect)
    }
    
    override public func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.leftViewRect(forBounds: bounds)
        return rect.inset(by: self.leftViewRect)
    }
}



public protocol CombineCompatible {}

// MARK: - UIControl
public extension UIControl {
    final class Subscription<SubscriberType: Subscriber, Control: UIControl>: Combine.Subscription where SubscriberType.Input == Control {
        private var subscriber: SubscriberType?
        private let input: Control

        public init(subscriber: SubscriberType, input: Control, event: UIControl.Event) {
            self.subscriber = subscriber
            self.input = input
            input.addTarget(self, action: #selector(eventHandler), for: event)
        }

        public func request(_ demand: Subscribers.Demand) {}

        public func cancel() {
            subscriber = nil
        }

        @objc private func eventHandler() {
            _ = subscriber?.receive(input)
        }
    }

    struct Publisher<Output: UIControl>: Combine.Publisher {
        public typealias Output = Output
        public typealias Failure = Never

        let output: Output
        let event: UIControl.Event

        public init(output: Output, event: UIControl.Event) {
            self.output = output
            self.event = event
        }

        public func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = Subscription(subscriber: subscriber, input: output, event: event)
            subscriber.receive(subscription: subscription)
        }
    }
}

extension UIControl: CombineCompatible {}

public extension CombineCompatible where Self: UIControl {
    func publisher(for event: UIControl.Event) -> UIControl.Publisher<UIControl> {
        .init(output: self, event: event)
    }
}
