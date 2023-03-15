//
//  Latest.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 15.03.2023.
//

import Foundation

struct Latest: Codable {
    let category: String
    let name: String
    let price: Int
    let image_url: String
}

struct GetAllLatests: Codable {
    let latest: [Latest]
}
