//
//  UIViewController+.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 7/22/24.
//

import Combine
import UIKit

extension UIViewController {
    var viewDidLoadPublisher: AnyPublisher<Void, Never> {
        let selector = #selector(UIViewController.viewDidLoad)
        return Just(selector)
            .map { _ in Void() }
            .eraseToAnyPublisher()
    }
}
