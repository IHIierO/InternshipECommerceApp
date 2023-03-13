//
//  AddSubviews.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 13.03.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
