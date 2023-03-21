//
//  TotalBlockDetailView.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 21.03.2023.
//

import UIKit

class TotalBlockDetailView: UIView {
    
    private let quantityLabel = DefaultUILabel(inputText: "Quantity:", customFont: CustomFonts.montserratRegular, fontSize: 12, colorForText: UIColor(hexString: "#808080"), alingment: .left)
    private let quantityCountLabel = DefaultUILabel(inputText: "44", customFont: CustomFonts.montserratMedium, fontSize: 15, colorForText: .white, alingment: .center)
    private let minusButton: UIButton = {
       let button = UIButton()
        button.configuration = .filled()
        button.configuration?.cornerStyle = .large
        button.configuration?.image = UIImage(systemName: "minus")
        button.configuration?.baseForegroundColor = UIColor(hexString: "#4E55D7")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let plusButton: UIButton = {
       let button = UIButton()
        button.configuration = .filled()
        button.configuration?.cornerStyle = .large
        button.configuration?.image = UIImage(systemName: "plus")
        button.configuration?.baseForegroundColor = UIColor(hexString: "#4E55D7")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let addToCartButton: UIButton = {
       let button = UIButton()
        button.configuration = .filled()
        button.configuration?.cornerStyle = .large
        button.configuration?.title = "ADD TO CART"
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: CustomFonts.montserratBold, size: 12)
            return outgoing
        }
        
        button.configuration?.subtitle = "# 2,500"
        button.configuration?.baseForegroundColor = UIColor(hexString: "#4E55D7")
       // button.configuration?.baseForegroundColor = UIColor(hexString: "#254FE6")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hexString: "#181726")
        clipsToBounds = true
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(quantityLabel, quantityCountLabel, minusButton, plusButton, addToCartButton)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setConstraints(){
        NSLayoutConstraint.activate([
            quantityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            quantityLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            
            minusButton.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 15),
            minusButton.leftAnchor.constraint(equalTo: quantityLabel.leftAnchor),
            minusButton.widthAnchor.constraint(equalToConstant: 40),
            minusButton.heightAnchor.constraint(equalToConstant: 22),
            
            quantityCountLabel.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 15),
            quantityCountLabel.leftAnchor.constraint(equalTo: minusButton.rightAnchor, constant: 2),
            quantityCountLabel.widthAnchor.constraint(equalToConstant: 22),
            quantityCountLabel.heightAnchor.constraint(equalToConstant: 22),
            
            plusButton.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 15),
            plusButton.leftAnchor.constraint(equalTo: quantityCountLabel.rightAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 40),
            plusButton.heightAnchor.constraint(equalToConstant: 22),
            
            addToCartButton.topAnchor.constraint(equalTo: quantityLabel.topAnchor),
            addToCartButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            addToCartButton.widthAnchor.constraint(equalToConstant: 200),
            addToCartButton.heightAnchor.constraint(equalToConstant: 54),
        ])
    }

}
