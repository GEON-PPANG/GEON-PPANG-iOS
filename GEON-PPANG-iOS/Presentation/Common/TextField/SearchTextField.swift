//
//  SearchTextField.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/09.
//

import UIKit

import SnapKit
import Then

final class SearchTextField: UITextField {
    
    // MARK: - Property
    
    var rightButtonType: RightButtonType = .searchButton
    var viewType: ViewType = .home
    var searchToBakeryList: ((String) -> Void)?
    var pushToSearchView: (() -> Void)?
    
    // MARK: - UI Property
    
    private lazy var searchButton = UIButton()
    private lazy var clearButton = UIButton()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setUI()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        [clearButton, searchButton].forEach {
            $0.snp.makeConstraints {
                $0.size.equalTo(24)
            }
        }
    }
    
    private func setUI() {
                
        searchButton.do {
            $0.setImage(.searchIcon400, for: .normal)
            $0.addAction(UIAction { _ in
                print("search Tapped")
            }, for: .touchUpInside)
        }
        
        clearButton.do {
            $0.setImage(.deleteIcon, for: .normal)
            $0.addAction(UIAction { _ in
                self.text?.removeAll()
            }, for: .touchUpInside)
        }
        
        self.do {
            $0.makeCornerRound(radius: 22)
            $0.backgroundColor = .gbbGray100
            $0.placeholder = I18N.Home.searchPlaceholder
            $0.setPlaceholder(color: .gbbGray300!, font: .bodyM1!)
            $0.setLeftPadding(amount: 15)
            updateRightViewMode()
        }
    }
    
    private func setDelegate() {
        
        self.delegate = self
    }
    
    private func addRightButton(_ buttonType: RightButtonType) {
        
        rightButtonType = buttonType
        updateRightViewMode()
    }
    
    private func updateRightViewMode() {
        
        switch rightButtonType {
        case .searchButton:
            rightView = searchButton
            rightViewMode = .unlessEditing
        case .clearButton:
            rightView = clearButton
            rightViewMode = .whileEditing
        }
    }
    
    func configureViewType(_ viewtype: ViewType) {
        
        self.viewType = viewtype
    }
    
    func fetchText() -> String {
        
        return text ?? ""
    }
}

// MARK: - UITextFieldDelegate

extension SearchTextField: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if self.isEmpty {
            addRightButton(.searchButton)
        } else {
            addRightButton(.clearButton)
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        switch viewType {
        case .home:
            self.pushToSearchView?()
            return false
        case .search: return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchToBakeryList?(fetchText())
        resignFirstResponder()
        return true
    }
    
    override public func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.rightViewRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets(top: 0,
                                           left: -15,
                                           bottom: 0,
                                           right: 15))
    }
}
