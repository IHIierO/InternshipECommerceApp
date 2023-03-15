//
//  FlashSale.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 15.03.2023.
//

import Foundation

struct FlashSale: Codable {
    let category: String
    let name: String
    let price: Double
    let discount: Int
    let image_url: String
}

struct GetAllLFlashSale: Codable {
    let flash_sale: [FlashSale]
}
