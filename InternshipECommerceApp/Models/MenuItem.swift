//
//  MenuItem.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 13.03.2023.
//

import Foundation

enum MenuItem: CaseIterable {
    case cars
    case games
    case phones
    case headPhones
    case kids
    case furniture
    
    var name: String {
        switch self {
        case .cars:
            return "Cars"
        case .games:
            return "Games"
        case .phones:
            return "Phones"
        case .headPhones:
            return "HeadPhones"
        case .kids:
            return "Kids"
        case .furniture:
            return "Furniture"
        }
    }
    var image: String {
        switch self {
        case .cars:
            return "menuItemCars"
        case .games:
            return "menuItemGames"
        case .phones:
            return "menuItemPhones"
        case .headPhones:
            return "menuItemHeadPhones"
        case .kids:
            return "menuItemKids"
        case .furniture:
            return "menuItemFurniture"
        }
    }
}
