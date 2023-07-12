//
//  FilterPurposeViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 2023/07/12.
//

import UIKit

import SnapKit
import Then

final class FilterPurposeViewController: BaseViewController {
    
    // MARK: - Property
    
    private var maxSteps: Int = 0
    
    // MARK: - UI Property
    
    private let filterTitleLabel = UILabel()
    private let filterSubtitleLabel = UILabel()
    private let filterCollectionView = UICollectionView()
    
    // MARK: - Life Cycle
    
    init(maxSteps: Int) {
        super.init(nibName: nil, bundle: nil)
        
        setMaxSteps(to: maxSteps)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setMaxSteps(to steps: Int) {
        self.maxSteps = steps
    }
    
    // MARK: - Action Helper
    
    
    
    // MARK: - Custom Method
    
    
    
}
