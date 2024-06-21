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
        self.setBindings()
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
    
    private func setBindings() {
        let action = UIAction { _ in self.text = "" }
        self.rightButton.addAction(action, for: .touchUpInside)
    }
        
    func build() -> UITextField {
        return self
    }
}

extension TextFieldBuilder {

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


#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import UIKit

@available(iOS 13.0, *)
public extension UITextField {
    /// A publisher emitting any text changes to a this text field.
    var textPublisher: AnyPublisher<String?, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.text)
                  .eraseToAnyPublisher()
    }

    /// A publisher emitting any attributed text changes to this text field.
    var attributedTextPublisher: AnyPublisher<NSAttributedString?, Never> {
        Publishers.ControlProperty(control: self, events: .defaultValueEvents, keyPath: \.attributedText)
                  .eraseToAnyPublisher()
    }

    /// A publisher that emits whenever the user taps the return button and ends the editing on the text field.
    var returnPublisher: AnyPublisher<Void, Never> {
        controlEventPublisher(for: .editingDidEndOnExit)
    }

    /// A publisher that emits whenever the user taps the text fields and begin the editing.
    var didBeginEditingPublisher: AnyPublisher<Void, Never> {
        controlEventPublisher(for: .editingDidBegin)
    }
}
#endif

#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import Foundation
import UIKit.UIControl

// MARK: - Publisher
@available(iOS 13.0, *)
public extension Combine.Publishers {
    /// A Control Property is a publisher that emits the value at the provided keypath
    /// whenever the specific control events are triggered. It also emits the keypath's
    /// initial value upon subscription.
    struct ControlProperty<Control: UIControl, Value>: Publisher {
        public typealias Output = Value
        public typealias Failure = Never

        private let control: Control
        private let controlEvents: Control.Event
        private let keyPath: KeyPath<Control, Value>

        /// Initialize a publisher that emits the value at the specified keypath
        /// whenever any of the provided Control Events trigger.
        ///
        /// - parameter control: UI Control.
        /// - parameter events: Control Events.
        /// - parameter keyPath: A Key Path from the UI Control to the requested value.
        public init(control: Control,
                    events: Control.Event,
                    keyPath: KeyPath<Control, Value>) {
            self.control = control
            self.controlEvents = events
            self.keyPath = keyPath
        }

        public func receive<S: Subscriber>(subscriber: S) where S.Failure == Failure, S.Input == Output {
            let subscription = Subscription(subscriber: subscriber,
                                            control: control,
                                            event: controlEvents,
                                            keyPath: keyPath)

            subscriber.receive(subscription: subscription)
        }
    }
}

// MARK: - Subscription
@available(iOS 13.0, *)
extension Combine.Publishers.ControlProperty {
    private final class Subscription<S: Subscriber, Control: UIControl, Value>: Combine.Subscription where S.Input == Value {
        private var subscriber: S?
        weak private var control: Control?
        let keyPath: KeyPath<Control, Value>
        private var didEmitInitial = false
        private let event: Control.Event

        init(subscriber: S, control: Control, event: Control.Event, keyPath: KeyPath<Control, Value>) {
            self.subscriber = subscriber
            self.control = control
            self.keyPath = keyPath
            self.event = event
            control.addTarget(self, action: #selector(processControlEvent), for: event)
        }

        func request(_ demand: Subscribers.Demand) {
            // Emit initial value upon first demand request
            if !didEmitInitial,
                demand > .none,
                let control = control,
                let subscriber = subscriber {
                _ = subscriber.receive(control[keyPath: keyPath])
                didEmitInitial = true
            }

            // We don't care about the demand at this point.
            // As far as we're concerned - UIControl events are endless until the control is deallocated.
        }

        func cancel() {
            control?.removeTarget(self, action: #selector(processControlEvent), for: event)
            subscriber = nil
        }

        @objc private func processControlEvent() {
            guard let control = control else { return }
            _ = subscriber?.receive(control[keyPath: keyPath])
        }
    }
}

extension UIControl.Event {
    static var defaultValueEvents: UIControl.Event {
        return [.allEditingEvents, .valueChanged]
    }
}
#endif
#if !(os(iOS) && (arch(i386) || arch(arm)))

@available(iOS 13.0, *)
public extension UIControl {
    /// A publisher emitting events from this control.
    func controlEventPublisher(for events: UIControl.Event) -> AnyPublisher<Void, Never> {
        Publishers.ControlEvent(control: self, events: events)
                  .eraseToAnyPublisher()
    }
}
#endif


// MARK: - Publisher
@available(iOS 13.0, *)
public extension Combine.Publishers {
    /// A Control Event is a publisher that emits whenever the provided
    /// Control Events fire.
    struct ControlEvent<Control: UIControl>: Publisher {
        public typealias Output = Void
        public typealias Failure = Never

        private let control: Control
        private let controlEvents: Control.Event

        /// Initialize a publisher that emits a Void
        /// whenever any of the provided Control Events trigger.
        ///
        /// - parameter control: UI Control.
        /// - parameter events: Control Events.
        public init(control: Control,
                    events: Control.Event) {
            self.control = control
            self.controlEvents = events
        }

        public func receive<S: Subscriber>(subscriber: S) where S.Failure == Failure, S.Input == Output {
            let subscription = Subscription(subscriber: subscriber,
                                            control: control,
                                            event: controlEvents)

            subscriber.receive(subscription: subscription)
        }
    }
}

// MARK: - Subscription
@available(iOS 13.0, *)
extension Combine.Publishers.ControlEvent {
    private final class Subscription<S: Subscriber, Control: UIControl>: Combine.Subscription where S.Input == Void {
        private var subscriber: S?
        weak private var control: Control?

        init(subscriber: S, control: Control, event: Control.Event) {
            self.subscriber = subscriber
            self.control = control
            control.addTarget(self, action: #selector(processControlEvent), for: event)
        }

        func request(_ demand: Subscribers.Demand) {
            // We don't care about the demand at this point.
            // As far as we're concerned - UIControl events are endless until the control is deallocated.
        }

        func cancel() {
            subscriber = nil
        }

        @objc private func processControlEvent() {
            _ = subscriber?.receive()
        }
    }
}
