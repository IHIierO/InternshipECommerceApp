//
//  HeaderForCollectionView.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 14.03.2023.
//

import UIKit

class HeaderForCollectionView: UICollectionReusableView {
    
    static let reuseId = "Header"
   
    let headerLabel: UILabel = {
       let headerLabel = UILabel()
        headerLabel.textAlignment = .left
        headerLabel.font = UIFont(name: CustomFonts.montserratMedium, size: 18)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        return headerLabel
    }()
    private let viewAllButton: UIButton = {
       let button = UIButton()
        button.configuration = .borderless()
        button.configuration?.title = "View all"
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: CustomFonts.montserratLight, size: 11)
            return outgoing
        }
        button.configuration?.baseForegroundColor = UIColor(hexString: "#808080")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: setConstraints
    
    private func setConstraints(){
        
        self.addSubviews(headerLabel, viewAllButton)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            headerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            headerLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            viewAllButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            viewAllButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            //viewAllButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            viewAllButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
    }
}
