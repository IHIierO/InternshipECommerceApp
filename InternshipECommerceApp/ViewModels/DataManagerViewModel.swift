//
//  DataManagerViewModel.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 16.03.2023.
//

import Foundation
import Combine

final class DataManagerViewModel {
    @Published private var latestIsExist = false
    @Published private var flashSaleIsExist = false
    
    enum Exists {
        case latest, flashSale
    }
    
    private var latestIsExistPublisher: AnyPublisher<Bool, Never> {
        $latestIsExist
            .map {$0 == true}
            .eraseToAnyPublisher()
    }
    
    private var flashSaleIsExistPublisher: AnyPublisher<Bool, Never> {
        $flashSaleIsExist
            .map {$0 == true}
            .eraseToAnyPublisher()
    }
    
    public var allDataEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(latestIsExistPublisher, flashSaleIsExistPublisher)
            .map {$0 && $1}
            .eraseToAnyPublisher()
    }
    
    public func updatePublishers(for data: Exists) {
        let keypath = specificKeypathForData(data)
        self[keyPath: keypath] = true
    }
    
    private func specificKeypathForData(_ data: Exists) -> ReferenceWritableKeyPath<DataManagerViewModel,Bool> {
        switch data {
        case .latest:
            return \.latestIsExist
        case .flashSale:
            return \.flashSaleIsExist
        }
    }
}
