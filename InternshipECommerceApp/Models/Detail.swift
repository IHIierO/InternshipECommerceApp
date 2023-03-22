//
//  Detail.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 22.03.2023.
//

import Foundation

struct Detail: Codable {
    var name: String
    var description:  String
    var rating: Double
    var number_of_reviews: Int
    var price: Int
    var colors: [String]
    var image_urls: [String]
}
