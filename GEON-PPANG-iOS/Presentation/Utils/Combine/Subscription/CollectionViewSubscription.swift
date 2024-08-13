//
//  CollectionViewSubscription.swift
//  GEON-PPANG-iOS
//
//  Created by JEONGEUN KIM on 8/13/24.
//

import Combine

import UIKit


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
