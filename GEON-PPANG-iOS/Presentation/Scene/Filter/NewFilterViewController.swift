//
//  NewFilterViewController.swift
//  GEON-PPANG-iOS
//
//  Created by 이성민 on 6/30/24.
//

import Combine
import UIKit

import SnapKit

final class NewFilterViewController: UIViewController {
    
    // MARK: - properties
    
    private let isInitial: Bool
    private var filterType: NewFilterType = .breadType
    
    // MARK: - ui properties
    
    private let navigationBar: UIView = {
        let view = UIView()
        view.backgroundColor = .gbbWhite
        return view
    }()
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gbbGray200
        return view
    }()
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(.icArrowLeft, for: .normal)
        return button
    }()
    private let stepLabel: UILabel = {
        let label = UILabel()
        label.font = .subHead
        label.textColor = .gbbGray300
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .title1
        label.textColor = .gbbGray700
        label.numberOfLines = 2
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .subHead
        label.textColor = .gbbGray400
        return label
    }()
    private let filterCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.register(cell: NewFilterCollectionViewCell.self)
        return collectionView
    }()
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("건너뛰기", for: .normal)
        button.setTitleColor(.gbbGray500, for: .normal)
        button.titleLabel?.font = .bodyM2
        let image = UIImage.icArrowRight.resize(to: .init(width: 16, height: 16))
        button.setImage(image, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.gbbGray400, for: .normal)
        button.backgroundColor = .gbbGray200
        button.makeCornerRound(radius: 12)
        return button
    }()
    
    // MARK: - life cycle
    
    init(isInitial: Bool) {
        self.isInitial = isInitial
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setDelegate()
        configureFilterStep()
    }
    
    // MARK: - setup
    
    private func setUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(74)
        }
        
        navigationBar.addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        navigationBar.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(5)
            $0.size.equalTo(48)
        }
        
        navigationBar.addSubview(stepLabel)
        stepLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(24)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(72)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
        
        view.addSubview(filterCollectionView)
        filterCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(124)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalTo(nextButton.snp.top).offset(-50)
        }
        
        if isInitial {
            view.addSubview(skipButton)
            skipButton.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(12)
                $0.bottom.equalTo(nextButton.snp.top).offset(-16)
            }
        }
    }
    
    private func setDelegate() {
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
    }
    
    private func configureFilterStep() {
        stepLabel.text = "\(filterType.rawValue)/3"
        titleLabel.text = filterType.title
        if let description = filterType.description {
            descriptionLabel.text = description
        }
    }
}

extension NewFilterViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
}

extension NewFilterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let size = collectionView.bounds.size
        switch filterType {
        case .purpose, .ingredient:
            let cellHeight = size.width/3.5
            return .init(width: size.width, height: cellHeight)
        case .breadType:
            let cellWidth = size.width/2 - 10
            let cellHeight = min(size.height/2 - 10, 160)
            return .init(width: cellWidth, height: cellHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension NewFilterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterType.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NewFilterCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let data = filterType.dataSource[indexPath.item]
        cell.configureContent(title: data.title, description: data.description)
        return cell
    }
    
    
}
