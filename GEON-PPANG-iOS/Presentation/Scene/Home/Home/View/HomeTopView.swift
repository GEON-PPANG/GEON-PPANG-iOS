//
//  HomeTopView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/07/09.
//

import UIKit

import SnapKit

final class HomeTopView: UIView {
    
    // MARK: - Property
    
    var pushToSearchView: (() -> Void)?
    
    // MARK: - UI Property
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .title1
        label.textColor = .gbbGray700
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    private lazy var searchTextField: SearchTextField = {
        let textField = SearchTextField()
        textField.configureViewType(.home)
        textField.pushToSearchView = { [weak self] in
            self?.pushToSearchView?()
        }
        return textField
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton()
        button.setImage(.homeFilterButton, for: .normal)
        return button
    }()
    
    private let lineView = LineView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {

        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(44)
            $0.leading.equalToSuperview().offset(24)
        }
        
        self.addSubview(filterButton)
        filterButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 48, height: 44))
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        self.addSubview(searchTextField)
        searchTextField.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(filterButton.snp.top)
            $0.trailing.equalTo(filterButton.snp.leading).offset(-12)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        self.addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview()
        }
    }

    func configureTitleText(_ title: String) {
        titleLabel.text = "\(title)님\n건빵에 오신걸 환영해요!"
    }
    
    // MARK: - Custom Method
    
    func addActionToFilterButton(_ action: @escaping () -> Void) {
        filterButton.addAction(UIAction { _ in
            action()
        }, for: .touchUpInside)
    }
}
