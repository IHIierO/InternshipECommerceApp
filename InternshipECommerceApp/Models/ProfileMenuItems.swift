//
//  ProfileMenuItems.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 17.03.2023.
//

import UIKit


enum ProfileMenuItems: CaseIterable {
    case tradeStore
    case paymaentMethod
    case balance
    case tradeHistory
    case restorePurshase
    case help
    case logOut
    
    var itemName: String {
        switch self {
        case .tradeStore:
            return "Trade store"
        case .paymaentMethod:
            return "Paymaent method"
        case .balance:
            return "Balance"
        case .tradeHistory:
            return "Trade history"
        case .restorePurshase:
            return "Restore Purshase"
        case .help:
            return "Help"
        case .logOut:
            return "Log out"
        }
    }
    
    var itemImage: UIImage? {
        switch self {
        case .tradeStore:
            return UIImage(named: "cartProfileMenuItem")
        case .paymaentMethod:
            return UIImage(named: "cartProfileMenuItem")
        case .balance:
            return UIImage(named: "cartProfileMenuItem")
        case .tradeHistory:
            return UIImage(named: "cartProfileMenuItem")
        case .restorePurshase:
            return UIImage(named: "restoreProfileMenuItem")
        case .help:
            return UIImage(named: "helpProfileMenuItem")
        case .logOut:
            return UIImage(named: "logOutProfileMenuItem")
        }
    }
    
    var itemIndicator:  UITableViewCell.AccessoryType {
        switch self {
        case .tradeStore:
            return .disclosureIndicator
        case .paymaentMethod:
            return .disclosureIndicator
        case .balance:
            return .none
        case .tradeHistory:
            return .disclosureIndicator
        case .restorePurshase:
            return .disclosureIndicator
        case .help:
            return .none
        case .logOut:
            return .none
        }
    }
}
   
