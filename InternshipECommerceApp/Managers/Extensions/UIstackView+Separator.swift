//
//  UIstackView+Separator.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 21.03.2023.
//

import UIKit

extension UIStackView {
    func addSeparators(color : UIColor) {
        let i = self.arrangedSubviews.count
       // while i >= 0 {
            let separator = createSeparator(color: color)
            insertArrangedSubview(separator, at: i-1)
            separator.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
            //i -= 1
        //}
    }

    private func createSeparator(color : UIColor) -> UIView {
        let separator = UIView()
        separator.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        separator.backgroundColor = color
        return separator
    }
}
