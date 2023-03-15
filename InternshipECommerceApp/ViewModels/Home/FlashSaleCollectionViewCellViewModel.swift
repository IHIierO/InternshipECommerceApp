//
//  FlashSaleCollectionViewCellViewModel.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 15.03.2023.
//

import UIKit

final class FlashSaleCollectionViewCellViewModel: Hashable, Equatable {
    
    private let imageUrl: URL?
    public let categoryLabel: String
    public let nameLabel: String
    private let discountLabel: Int
    private let priceLabel: Double
    
    // MARK: - init
    init(
        imageUrl: URL?,
        categoryLabel: String,
        nameLabel: String,
        discountLabel: Int,
        priceLabel: Double
    ) {
        self.imageUrl = imageUrl
        self.categoryLabel = categoryLabel
        self.nameLabel = nameLabel
        self.discountLabel = discountLabel
        self.priceLabel = priceLabel
    }
    
    public var priceLabelText: String {
        return "$" + " " + String(describing: priceLabel)
    }
    public var discountLabelText: String {
        return String(describing: discountLabel) + "% off"
    }
    
    public func fethImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.dowloadImage(url, completion: completion)
    }
    
    // MARK: - Hashable
    
    static func == (lhs: FlashSaleCollectionViewCellViewModel, rhs: FlashSaleCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(imageUrl)
        hasher.combine(categoryLabel)
        hasher.combine(nameLabel)
        hasher.combine(discountLabel)
        hasher.combine(priceLabel)
    }
}
