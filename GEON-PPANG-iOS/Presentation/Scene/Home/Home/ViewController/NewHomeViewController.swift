//
//  NewHomeViewController.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 7/9/24.
//

import Combine

import UIKit
import SnapKit

final class NewHomeViewController: UIViewController {
    
    enum Sections: Int, CaseIterable {
        case bakery
        case review
        case bottom
    }
    
    enum Item: Hashable {
        case bakery(BestBakery)
        case review(BestReview)
        case bottom
    }
    
    // MARK: - Property
    
    private var dataSource: UICollectionViewDiffableDataSource<Sections, Item>?
    private var snapShot: NSDiffableDataSourceSnapshot<Sections, Item>?
    
    private let viewModel: any ViewModelType
    private var cancelBag: Set<AnyCancellable> = Set()
    
    // MARK: - UI Property
    
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    private let topView: HomeTopView = {
        let view = HomeTopView()
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .gbbBackground1
        collectionView.register(HomeBakeryCollectionViewCell.self,
                                forCellWithReuseIdentifier: HomeBakeryCollectionViewCell.identifier)
        collectionView.register(HomeReviewCollectionViewCell.self,
                                forCellWithReuseIdentifier: HomeReviewCollectionViewCell.identifier)
        collectionView.register(HomeBottomCollectionViewCell.self,
                                forCellWithReuseIdentifier: HomeBottomCollectionViewCell.identifier)
        collectionView.register(HomeHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HomeHeaderView.identifier)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setUI()
        setViewModel()
        setDataSource()
        bindCollectionViewEvents()
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
        let input = HomeViewModel.Input(viewDidLoad: self.viewDidLoadPublisher)
        return viewModel.transform(input)
    }
    
    private func bindOutputToViewModel(_ output: HomeViewModel.Output?) {
        guard let output else { return }
        
        output.bakery
            .receive(on: RunLoop.main)
            .sink { completion in
                print("completion:\(completion)")
            } receiveValue: { [weak self] bakery in
                self?.reloadBestList(bakery: bakery)
            }
            .store(in: &self.cancelBag)
        
        output.review
            .receive(on: RunLoop.main)
            .sink { completion in
                print("completion:\(completion)")
            } receiveValue: { [weak self] review in
                self?.reloadBestList(review: review)
            }
            .store(in: &self.cancelBag)
    }
}

extension NewHomeViewController {
    
    func setDataSource() {
        self.dataSource = self.BestCollectionViewDataSource()
        self.configureSnapshot()
        self.configureSupplementaryView()
    }
    
    func BestCollectionViewDataSource() -> UICollectionViewDiffableDataSource<Sections, Item> {
        let dataSource = UICollectionViewDiffableDataSource<Sections, Item>(collectionView: collectionView) { collectionView, indexPath, item in
            
            switch item {
            case .bakery(let data):
                let cell: HomeBakeryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configureCellUI(data: data)
                return cell
            case .review(let data):
                let cell: HomeReviewCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configureCellUI(data: data)
                return cell
            case .bottom:
                let cell: HomeBottomCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                return cell
            }
        }
        
        return dataSource
    }
    
    private func configureSupplementaryView() {
        dataSource?.supplementaryViewProvider = { (collectionView, _, indexPath) in
            guard let section = Sections(rawValue: indexPath.section) else { fatalError() }
            
            let header: HomeHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, indexPath: indexPath)
            
            //  header.configureSectionHeaderTitle("", "")
            return header
        }
    }
    
    func configureSnapshot() {
        self.snapShot = NSDiffableDataSourceSnapshot<Sections, Item>()
        snapShot?.appendSections([.bakery,.review,.bottom])
        if let snapShot {
            self.dataSource?.apply(snapShot)
        }
    }
    
    private func reloadBestList(bakery: [BestBakery] = [], review: [BestReview] = []) {
        // 현재 스냅샷을 가져와서 기존의 아이템이 비어있을 때만 update
        guard var snapShot = self.dataSource?.snapshot() else { return }
        
        let previousBakeryData = snapShot.itemIdentifiers(inSection: .bakery)
        let previousReviewData = snapShot.itemIdentifiers(inSection: .review)
        
        if previousBakeryData.isEmpty {
            let bakeryItems = bakery.map { Item.bakery($0) }
            snapShot.appendItems(bakeryItems, toSection: .bakery)
        }
        
        if previousReviewData.isEmpty {
            let reviewItems = review.map { Item.review($0) }
            snapShot.appendItems(reviewItems, toSection: .review)
        }
        
        snapShot.appendItems([.bottom], toSection: .bottom)
        
        self.dataSource?.apply(snapShot, animatingDifferences: false)
    }
}

extension NewHomeViewController {
    
    private func bindCollectionViewEvents() {
        let didSelectPublisher = CollectionViewPublisher(collectionView: collectionView, event: .didSelect)
        didSelectPublisher
            .sink { [weak self] indexPath in
                self?.handleSelection(for: indexPath)
            }
            .store(in: &cancelBag)
    }
    
    private func handleSelection(for indexPath: IndexPath) {
        guard let (id, bakery) = getBakeryData(for: indexPath) else { return }
        
        self.navigateToDetailViewController(with: id)
        self.logAnalytics(for: bakery)
    }

    private func getBakeryData(for indexPath: IndexPath) -> (Int, String)? {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else { return nil }
        
        switch item {
        case .bakery(let data):
            return (data.overview.id, data.overview.name)
        case .review(let data):
            return (data.overview.id, data.overview.name)
        default:
            return nil
        }
    }

    private func navigateToDetailViewController(with id: Int) {
        let nextViewController = BakeryDetailViewController()
        nextViewController.bakeryID = id
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(nextViewController, animated: true)
    }

    private func logAnalytics(for bakery: String) {
        AnalyticManager.log(event: .home(.clickRecommendStore(bakery: bakery)))
        AnalyticManager.log(event: .detail(.viewDetailpageAt(source: AnalyticEventType.HOME.rawValue)))
    }
}

// MARK: - CollectionView Layout

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
        
        let itemGroupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(convertByWidthRatio(192)),
            heightDimension: .absolute(heightConsideringNotch(236))
        )
        let item = NSCollectionLayoutItem(layoutSize: itemGroupSize)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemGroupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = bestSectionHeader(to: headerSize)
        section.contentInsets = NSDirectionalEdgeInsets(top: 24,
                                                        leading: 24,
                                                        bottom: 30,
                                                        trailing: 24)
        
        return section
    }
    
    private func bottomSection() -> NSCollectionLayoutSection {
        
        let itemGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(72)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemGroupSize)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: itemGroupSize,
            subitem: item,
            count: 1
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 14,
                                                        leading: 24,
                                                        bottom: 30,
                                                        trailing: 24)
        
        return section
    }
    
    private func bestSectionHeader(to size: CGFloat) -> [NSCollectionLayoutBoundarySupplementaryItem] {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(size)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        return [header]
    }
}

enum Event {
    case didSelect
    case didDeselect
}

final class CollectionViewSubscription<SubscriberType: Subscriber>: Subscription where SubscriberType.Input == IndexPath {
    private var subscriber: SubscriberType?
    private weak var collectionView: UICollectionView?
    private var delegateProxy: CollectionViewDelegateProxy?
    
    init(subscriber: SubscriberType, collectionView: UICollectionView, event: Event) {
        self.subscriber = subscriber
        self.collectionView = collectionView
        
        let delegateProxy = CollectionViewDelegateProxy(
            event: event,
            handler: { [weak self] indexPath in
                _ = self?.subscriber?.receive(indexPath)
            }
        )
        
        self.delegateProxy = delegateProxy
        collectionView.delegate = delegateProxy
    }
    
    func request(_ demand: Subscribers.Demand) {
        // 요구 처리 로직 추가 가능
    }
    
    func cancel() {
        subscriber = nil
        delegateProxy = nil
    }
}

private class CollectionViewDelegateProxy: NSObject, UICollectionViewDelegate {
    private let event: Event
    private let handler: (IndexPath) -> Void
    
    init(event: Event, handler: @escaping (IndexPath) -> Void) {
        self.event = event
        self.handler = handler
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if event == .didSelect {
            handler(indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if event == .didDeselect {
            handler(indexPath)
        }
    }
}

struct CollectionViewPublisher: Publisher {
    typealias Output = IndexPath
    typealias Failure = Never
    
    let collectionView: UICollectionView
    let event: Event
    
    func receive<S>(subscriber: S) where S: Subscriber, S.Input == IndexPath, S.Failure == Never {
        let subscription = CollectionViewSubscription(
            subscriber: subscriber,
            collectionView: collectionView,
            event: event
        )
        subscriber.receive(subscription: subscription)
    }
}
