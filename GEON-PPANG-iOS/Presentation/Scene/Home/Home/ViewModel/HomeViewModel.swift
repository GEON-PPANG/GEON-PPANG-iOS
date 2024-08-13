//
//  HomeViewModel.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 7/9/24.
//

import Combine

import Foundation

final class HomeViewModel: ViewModelType {
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let bakery: AnyPublisher<[BestBakery], Never>
        let review: AnyPublisher<[BestReview], Never>
    }
    
    // MARK: - Property
    
    private let usecase: HomeUseCase
    private var cancellable: Set<AnyCancellable> = Set()
    
    private var bakerySubject = CurrentValueSubject<[BestBakery], Never>([])
    private var reviewSubject = CurrentValueSubject<[BestReview], Never>([])
    
    init(usecase: HomeUseCase) {
        self.usecase = usecase
    }
    
    // MARK: - func
    
    func transform(_ input: Input) -> Output {
        input.viewDidLoad
            .sink { [weak self] in
                self?.fetchData()
            }
            .store(in: &cancellable)
        
        return Output(bakery: bakerySubject.eraseToAnyPublisher(),
                      review: reviewSubject.eraseToAnyPublisher())
    }
    
    private func fetchData() {
        Task {
            do {
                let bakeries = try await fetchBestBakery()
                bakerySubject.send(bakeries) 
            } catch {
                bakerySubject.send([])
            }
        }
        
        Task {
            do {
                let reviews = try await fetchBestReview()
                reviewSubject.send(reviews)
            } catch {
                reviewSubject.send([])
            }
        }
    }
}

extension HomeViewModel {
    private func fetchBestBakery() async throws -> [BestBakery] {
        return try await self.usecase.fetchBestBakeries()
    }
    
    private func fetchBestReview() async throws -> [BestReview] {
        return try await self.usecase.fetchBestReviews()
    }
}
