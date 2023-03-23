//
//  LatestCollectionViewCellViewModel.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 15.03.2023.
//

import UIKit

final class LatestCollectionViewCellViewModel: Hashable, Equatable {
    
    private let imageUrl: URL?
    public let categoryLabel: String
    public let nameLabel: String
    private let priceLabel: Int
    
    // MARK: - init
    init(
        imageUrl: URL?,
        categoryLabel: String,
        nameLabel: String,
        priceLabel: Int
    ) {
        self.imageUrl = imageUrl
        self.categoryLabel = categoryLabel
        self.nameLabel = nameLabel
        self.priceLabel = priceLabel
    }
    
    public var priceLabelText: String {
        return "$" + " " + String(describing: priceLabel)
    }
    
    public func fethImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.dowloadImage(url, completion: completion)
    }
    
    // MARK: - Hashable
    static func == (lhs: LatestCollectionViewCellViewModel, rhs: LatestCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(imageUrl)
        hasher.combine(categoryLabel)
        hasher.combine(nameLabel)
        hasher.combine(priceLabel)
    }
}

