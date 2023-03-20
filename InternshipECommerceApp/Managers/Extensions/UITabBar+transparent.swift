//
//  TransparentTabbar.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 14.03.2023.
//

import UIKit

extension UITabBar {
    
    static func setTransparentTabbar() {
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage     = UIImage()
        UITabBar.appearance().clipsToBounds   = true
    }
}
