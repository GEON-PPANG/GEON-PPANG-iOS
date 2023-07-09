//
//  SearchTextField.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/09.
//

import UIKit

import SnapKit
import Then

enum RightButtonType {
    case searchButton
    case clearButton
}
enum ViewType {
    case home
    case search
}

final class SearchTextField: UITextField {
    
    // MARK: - Property
    
    var rightButtonType: RightButtonType = .searchButton
    var viewType: ViewType = .home
    var textFieldClosure: ((String) -> Void)?
    
    // MARK: - UI Property
    
    private lazy var searchButton = UIButton()
    private lazy var clearButton = UIButton()
    private let emptyView = UIView()
    private let rightStackView = UIStackView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setUI() {
        clearButtonMode = .never
        
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
            $0.placeholder = I18N.Home.searchPlacehold
            $0.setPlaceholder(color: .gbbGray300!)
            $0.setLeftPadding(amount: 15)
            updateRightViewMode()
            $0.rightView = rightStackView
        }
    }
    
    private func setLayout() {
        rightStackView.snp.makeConstraints {
            $0.width.equalTo(40)
        }
        
        emptyView.snp.makeConstraints {
            $0.width.equalTo(15)
        }
        
        [clearButton, searchButton].forEach {
            $0.snp.makeConstraints {
                $0.size.equalTo(24)
            }
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
            rightStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            rightStackView.addArrangedSubviews(searchButton, emptyView)
            rightViewMode = .unlessEditing
        case .clearButton:
            rightStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            rightStackView.addArrangedSubviews(clearButton, emptyView)
            rightViewMode = .whileEditing
        }
    }
    
    func viewType(_ viewtype: ViewType) {
        self.viewType = viewtype
    }
    
    func getText() -> String {
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
        case .home: return false
        case .search: return true
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("🤍\(getText())")
        textFieldClosure?(getText())
        resignFirstResponder()
        return true
    }
}
