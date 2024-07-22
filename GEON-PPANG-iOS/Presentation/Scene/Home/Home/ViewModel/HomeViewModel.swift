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
        let bakery: AnyPublisher<[BestBakery], Error>
        let review: AnyPublisher<[BestReview], Error>
    }
    
    // MARK: - Property
    
    private let usecase: HomeUseCase
    private var cancellable: Set<AnyCancellable> = Set()

    init(usecase: HomeUseCase) {
        self.usecase = usecase
    }
    
    // MARK: - func
    
    func transform(_ input: Input) -> Output {
        let bakery = input.viewDidLoad
            .compactMap { [weak self] in self }
            .flatMap { _ -> AnyPublisher<[BestBakery], Error> in
                Future<[BestBakery], Error> { promise in
                    Task {
                        do {
                            let bakery = try await self.fetchBestBakery()
                            promise(.success(bakery))
                        } catch {
                            promise(.failure(error))
                        }
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        let review = input.viewDidLoad
            .compactMap { [weak self] in self }
            .flatMap {  _ -> AnyPublisher<[BestReview], Error> in
                return Future<[BestReview], Error> { promise in
                    Task {
                        do {
                            let review = try await self.fetchBestReview()
                                promise(.success(review))
                        } catch {
                            promise(.failure(error))
                        }
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()

        return Output(bakery: bakery, review: review)
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
