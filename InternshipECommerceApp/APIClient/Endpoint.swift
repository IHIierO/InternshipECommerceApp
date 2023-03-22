//
//  Endpoint.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 13.03.2023.
//

import Foundation

/// Represents unique API endpoints
@frozen enum Endpoint: String, CaseIterable, Hashable {
    /// Endpoint to get latest info
    case latest
    /// Endpoint to get flash sale info
    case flashSale
    /// Endpoint to get brands info
    case brands
    /// Endpoint to get detail info
    case detail
    
    var name: String {
        switch self {
        case .latest:
            return "cc0071a1-f06e-48fa-9e90-b1c2a61eaca7"
        case .flashSale:
            return "a9ceeb6e-416d-4352-bde6-2203416576ac"
        case .brands:
            return ""
        case .detail:
            return "f7f99d04-4971-45d5-92e0-70333383c239"
        }
    }
}
