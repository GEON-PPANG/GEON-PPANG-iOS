//
//  NewHomeViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 7/9/24.
//

import Combine

import UIKit

final class NewHomeViewController: UIViewController {
    
    // MARK: - Property
    
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    private let viewModel: any ViewModelType
    private var cancelBag: Set<AnyCancellable> = Set()
    
    private let viewWillAppearPublisher: PassthroughSubject<Void, Never> = PassthroughSubject()
    
    private var bakeryList: [BestBakery] = []
    private var reviewList: [BestReview] = []
    
    // MARK: - UI Property
    
    private let topView: HomeTopView = {
        let view = HomeTopView()
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .gbbBackground1
        collectionView.register(HomeBakeryCollectionViewCell.self, forCellWithReuseIdentifier: HomeBakeryCollectionViewCell.identifier)
        collectionView.register(HomeReviewCollectionViewCell.self, forCellWithReuseIdentifier: HomeReviewCollectionViewCell.identifier)
        collectionView.register(HomeBottomCollectionViewCell.self, forCellWithReuseIdentifier: HomeBottomCollectionViewCell.identifier)
        collectionView.register(HomeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeHeaderView.identifier)
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - init
    
    init(viewModel: any ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewWillAppearPublisher.send()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setUI()
        setViewModel()
    }
    
    private func setLayout() {
        
        view.addSubview(topView)
        topView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(heightConsideringNotch(44))
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.height.equalTo(200)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.directionalHorizontalEdges.equalTo(safeArea)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    private func setViewModel() {
        let output = transformedOutput()
        self.bindOutputToViewModel(output)
    }
    
    private func transformedOutput() -> HomeViewModel.Output? {
        guard let viewModel = self.viewModel as? HomeViewModel
        else { return nil }
        let input = HomeViewModel.Input(
            viewWillAppear: self.viewWillAppearPublisher
        )
        return viewModel.transform(input)
    }
    
    private func bindOutputToViewModel(_ output: HomeViewModel.Output?) {
        guard let output else { return }
        
        output.bakery
            .receive(on: RunLoop.main)
            .sink { err in
                print("error:\(err)")
            } receiveValue: { [weak self] bakery in
                dump(bakery)
                self?.updateBakery(bakery: bakery)
            }
            .store(in: &self.cancelBag)
        
        output.review
            .receive(on: RunLoop.main)
            .sink { err in
                print("error:\(err)")
            } receiveValue: { [weak self] review in
                dump(review)
                self?.updateReview(review: review)
            }
            .store(in: &self.cancelBag)
    }
    
    private func updateBakery(bakery:[BestBakery]) {
        self.bakeryList = bakery
        self.collectionView.reloadSections(IndexSet(integersIn: 0 ..< 1))
    }
    
    private func updateReview(review: [BestReview]) {
        self.reviewList = review
        self.collectionView.reloadSections(IndexSet(integersIn: 1 ..< 2))
    }
}

extension NewHomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return bakeryList.count
        case 1:
            return reviewList.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell: HomeBakeryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let item = self.bakeryList[indexPath.item]
            cell.configureCellUI(data: item)
            return cell
        case 1:
            let cell: HomeReviewCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let item = self.reviewList[indexPath.item]
            cell.configureCellUI(data: item)
            return cell
        case 2:
            let cell: HomeBottomCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeHeaderView.identifier,
                for: indexPath
              ) as? HomeHeaderView else { return UICollectionReusableView() }
        
        guard let title = Sections(rawValue: indexPath.section)?.title else { return UICollectionReusableView() }
        // nickname
        header.configureSectionHeaderTitle(nil, title)
        return header
    }
}

extension NewHomeViewController {
    private func layout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            switch sectionIndex {
            case 0:
                return self?.bestSection(headerSize: 49)
            case 1:
                return self?.bestSection(headerSize: 25)
            default:
                return self?.bottomSection()
            }
        })
    }
    
    private func bestSection(headerSize: CGFloat) -> NSCollectionLayoutSection {
        
        let itemGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(convertByWidthRatio(192)),
                                                   heightDimension: .absolute(heightConsideringNotch(236)))
        let item = NSCollectionLayoutItem(layoutSize: itemGroupSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemGroupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(headerSize))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        section.contentInsets = NSDirectionalEdgeInsets(top: 24,
                                                        leading: 24,
                                                        bottom: 30,
                                                        trailing: 24)
        
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func bottomSection() -> NSCollectionLayoutSection {
        
        let itemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(72))
        let item = NSCollectionLayoutItem(layoutSize: itemGroupSize)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemGroupSize,
                                                     subitem: item,
                                                     count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 14,
                                                        leading: 24,
                                                        bottom: 30,
                                                        trailing: 24)
        
        return section
    }
}
