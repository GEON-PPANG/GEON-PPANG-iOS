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
            $0.setImage(.Icon.Search.gray400, for: .normal)
        }
        
        clearButton.do {
            $0.setImage(.Icon.delete, for: .normal)
            $0.addAction(UIAction { _ in
                self.text?.removeAll()
            }, for: .touchUpInside)
        }
        
        self.do {
            $0.makeCornerRound(radius: CGFloat().convertByHeightRatio(22))
            $0.backgroundColor = .gbbGray100
            $0.placeholder = I18N.Search.searchPlaceholder
            configureButtonSubView()
        }
    }
    
    private func setDelegate() {
        
        self.delegate = self
    }
    
    private func configureButtonSubView() {
        
        switch viewType {
        case .search:
            setPlaceholder(color: .gbbGray300, font: .bodyM1!)
            leftView = searchButton
            leftViewMode = .always
            rightView = clearButton
            rightViewMode = .whileEditing
        case .home:
            setPlaceholder(color: .gbbGray300, font: .subHead!)
            setLeftPadding(amount: 0)
            rightView = searchButton
            rightViewMode = .always
        }
    }
    
    func configureViewType(_ type: ViewType) {
        
        self.viewType = type
        self.configureButtonSubView()
    }
    
    func fetchText() -> String {
        
        return text ?? ""
    }
}

// MARK: - UITextFieldDelegate

extension SearchTextField: UITextFieldDelegate {
    
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
    
    override public func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.leftViewRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets(top: 0,
                                           left: 15,
                                           bottom: 0,
                                           right: -15))
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets(top: 0,
                                           left: viewType == .home ? 0 : 12,
                                           bottom: 0,
                                           right: viewType == .home ? 0 : 15))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets(top: 0,
                                           left: viewType == .home ? 0 : 12,
                                           bottom: 0,
                                           right: viewType == .home ? 0 :15))
    }
    
}
