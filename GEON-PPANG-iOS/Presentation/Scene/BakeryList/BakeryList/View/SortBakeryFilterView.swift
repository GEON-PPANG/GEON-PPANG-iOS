//
//  SortBakeryFilterView.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 2023/09/03.
//

import UIKit

import SnapKit
import Then
import Moya

final class SortBakeryFilterView: UIView {
    
    // MARK: - Property
    
    var tappedCheckBox: ((Bool) -> Void)?
    
    // MARK: - UI Property
    
    private lazy var filterButton = UIButton(configuration: .plain())
    private let checkBoxTitle = UILabel()
    private var checkBox = UIButton(configuration: .plain())
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        
        self.addSubview(checkBox)
        checkBox.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
            $0.size.equalTo(20)
        }
        
        self.addSubview(checkBoxTitle)
        checkBoxTitle.snp.makeConstraints {
            $0.centerY.equalTo(checkBox.snp.centerY)
            $0.leading.equalTo(checkBox.snp.trailing).offset(8)
        }
        
        self.addSubview(filterButton)
        filterButton.snp.makeConstraints {
            $0.centerY.equalTo(checkBox.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
        }
        
    }
    
    private func setUI() {
        
        filterButton.do {
            $0.configuration?.baseForegroundColor = .gbbGray600
            $0.configuration?.contentInsets = .init(top: 11,
                                                    leading: 12,
                                                    bottom: 11,
                                                    trailing: 12)
            $0.configuration?.image = .Icon.swap.resize(to: CGSize(width: 16, height: 16))
            $0.configuration?.attributedTitle = AttributedString(I18N.BakeryList.defaultFilter,
                                                                 attributes: AttributeContainer([.font: UIFont.captionB1]))
            $0.configuration?.imagePadding = 5
        }
        
        checkBox.do {
            $0.tintColor = .clear
            $0.configurationUpdateHandler = configureCheckBoxHandler()
            $0.addAction(applyCheckBoxAction(), for: .touchUpInside)
        }
        
        checkBoxTitle.do {
            $0.basic(text: I18N.BakeryListFilter.title,
                     font: .captionB1,
                     color: .gbbGray600)
        }
    }
    
    func applyFilterAction(_ action: @escaping () -> Void) {
        
        let action = UIAction { _ in
            action()
        }
        filterButton.addAction(action, for: .touchUpInside)
    }
    
    func applyCheckBoxAction() -> UIAction {
        
        return UIAction { _ in
            self.tappedCheckBox?(self.checkBox.isSelected)
        }
    }
    
    func configureFilterButtonText(to text: String) {
        
        filterButton.do {
            $0.configuration?.attributedTitle = AttributedString(text,
                                                                 attributes: AttributeContainer([.font: UIFont.captionB1]))
        }
    }
    
    func configureCheckBoxHandler() -> UIButton.ConfigurationUpdateHandler {
        
        let handler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.state {
            case .selected:
                button.configuration?.image = .Icon.Filter.check
            default:
                button.configuration?.image = .Icon.Filter.uncheck
            }
        }
        return handler
    }
    
    func configureCheckBox() {
        
        self.checkBox.isSelected.toggle()
        self.checkBox.setNeedsUpdateConfiguration()
    }
    
    func tappedButton(_ isSelected: Bool) {
        
        self.checkBox.isSelected = isSelected
        
        guard KeychainService.readKeychain(of: .role) != UserRole.member.rawValue
        else { self.checkBox.isUserInteractionEnabled = isSelected; return }
    }
}
