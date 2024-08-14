//
//  CollectionViewPublisher.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 8/13/24.
//

import Combine

import UIKit

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

