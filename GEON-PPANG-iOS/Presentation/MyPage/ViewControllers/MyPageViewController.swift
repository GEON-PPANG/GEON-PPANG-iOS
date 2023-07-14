//
//  MyPageViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/08.
//

import UIKit

import SnapKit
import Then

final class MyPageViewController: UIViewController {

    let loginTextField = LoginTextFiledView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginTextField)
        
        loginTextField.do {
            $0.backgroundColor = .white
        }
        
        loginTextField.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(100)
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
        }

    }
}
