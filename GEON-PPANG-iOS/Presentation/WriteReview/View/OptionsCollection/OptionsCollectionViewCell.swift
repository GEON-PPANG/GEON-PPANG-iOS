//
//  OptionsCollectionViewCell.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/07.
//

import UIKit

import SnapKit
import Then

final class OptionsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    enum CellStatus {
        case deselected
        case selected
        case disabled
    }
    
    var status: CellStatus = .deselected
    
    var cellText: String = ""
    
    private var cellBorderColor: UIColor {
        switch status {
        case .deselected: return .gbbGray400!
        case .selected: return .gbbMain3!
        case .disabled: return .gbbGray300!
        }
    }
    
    private var cellTextColor: UIColor {
        switch status {
        case .deselected: return .gbbGray400!
        case .selected: return .gbbMain1!
        case .disabled: return .gbbGray300!
        }
    }
    
    // MARK: - UI Property
    
    private let cellLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        addSubview(cellLabel)
        cellLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.verticalEdges.equalToSuperview().inset(8)
        }
    }
    
    private func setUI() {
        self.do { $0.makeCornerRound(radius: 12.5) }
        cellLabel.do { $0.text = cellText }
        
        configureCell(to: status)
    }
    
    // MARK: - Custom Method
    
    func configureCell(to status: CellStatus) {
        self.status = status
        self.do { $0.makeBorder(width: 1.5, color: cellBorderColor) }
        cellLabel.do { $0.textColor = cellTextColor }
    }
    
    func toggleCellInteraction() {
        self.isUserInteractionEnabled.toggle()
    }
    
}
