//
//  CommonButton.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/06.
//

import UIKit

import Then

enum CommonButton: Buildable {
    
    typealias ViewType = UIButton
    
    case loginButton(title: String, completion: ((UIAction) -> Void)?=nil)
    case signInButton(title: String, completion: ((UIAction) -> Void)?=nil)
    case nextButton(title: String, color: UIColor, completion: ((UIAction) -> Void)?=nil)
    case confirmButton(title: String, completion: ((UIAction) -> Void)?=nil)
    case writeButton(title: String, completion: ((UIAction) -> Void)?=nil)
    case startButton(title: String, completion: ((UIAction) -> Void)?=nil)
    
    func build(_ config: ((UIButton) -> Void)?) -> UIButton {
        var button = makeCommonButton()
        if let config = config {
            button = button.then(config)
        }
        return button
    }
    
    private func makeCommonButton() -> UIButton {
        switch self {
        case .loginButton(title: let title, completion: let completion) :
            return UIButton.makeCommonButton(title: title, completion: completion).then {
                $0.backgroundColor = .lightGray
            }
        case .signInButton(title: let title, completion: let completion):
            return UIButton.makeCommonButton(title: title, completion: completion).then {
                $0.backgroundColor = .lightGray
            }
        case .nextButton(title: let title, color: let color, completion: let completion):
            return UIButton.makeCommonButton(title: title, completion: completion).then {
                $0.backgroundColor = color
            }
        case .confirmButton(title: let title, completion: let completion):
            return UIButton.makeCommonButton(title: title, completion: completion).then {
                $0.backgroundColor = .lightGray
            }
        case .writeButton(title: let title, completion: let completion):
            return UIButton.makeCommonButton(title: title, completion: completion).then {
                $0.backgroundColor = .lightGray
            }
        case .startButton(title: let title, completion: let completion):
            return UIButton.makeCommonButton(title: title, completion: completion).then {
                $0.backgroundColor = .lightGray
            }
        }
    }
}


extension UIButton {
    static func makeCommonButton(title: String, completion: ((UIAction) -> Void)? = nil) -> UIButton {
        let button = UIButton(frame: CGRect(), primaryAction: UIAction(title: title, handler: completion ?? {_ in return}))
        button.layer.cornerRadius = 11
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.clear.cgColor
        return button
    }
}
