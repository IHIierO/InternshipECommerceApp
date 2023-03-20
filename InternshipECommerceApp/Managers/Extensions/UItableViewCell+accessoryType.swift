//
//  UItableViewCell+accessoryType.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 17.03.2023.
//

import UIKit

extension UITableViewCell {
    func addCustomDisclosureIndicator(with color: UIColor) {
        accessoryType = .disclosureIndicator
        let disclosureImage = UIImage(named: "disclosureIndicator")?.withRenderingMode(.alwaysTemplate)
        let imageWidth = (disclosureImage?.size.width) ?? 7
        let imageHeight = (disclosureImage?.size.height) ?? 12
        let accessoryImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
        accessoryImageView.contentMode = .scaleAspectFit
        accessoryImageView.image = disclosureImage
        accessoryImageView.tintColor = color
        accessoryView = accessoryImageView
    }
}
