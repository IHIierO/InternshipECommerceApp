//
//  DescriptionBlockDetailView.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 21.03.2023.
//

import UIKit

class DescriptionBlockDetailView: UIView {
    public let nameLabel = DefaultUILabel(inputText: "", customFont: CustomFonts.montserratMedium, fontSize: 18, alingment: .left)
    public let priceLabel = DefaultUILabel(inputText: "", customFont: CustomFonts.montserratMedium, fontSize: 16, alingment: .right)
    public let descriptionLabel = DefaultUILabel(inputText: "", customFont: CustomFonts.montserratRegular, fontSize: 14, colorForText: UIColor(hexString: "#808080"), alingment: .left)
    public let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let colorsLabel = DefaultUILabel(inputText: "Color:", customFont: CustomFonts.montserratRegular, fontSize: 14, alingment: .left)
    public let colorsStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(nameLabel, priceLabel, descriptionLabel, ratingLabel, colorsLabel, colorsStackView)
        nameLabel.numberOfLines = 2
        descriptionLabel.numberOfLines = 0
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setConstraints(){
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            nameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            
            priceLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            priceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            priceLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.rightAnchor.constraint(equalTo: priceLabel.rightAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            descriptionLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            
            ratingLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            ratingLabel.rightAnchor.constraint(equalTo: priceLabel.rightAnchor),
            ratingLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            
            colorsLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 8),
            colorsLabel.rightAnchor.constraint(equalTo: priceLabel.rightAnchor),
            colorsLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            
            colorsStackView.topAnchor.constraint(equalTo: colorsLabel.bottomAnchor, constant: 4),
            colorsStackView.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            //colorsStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            colorsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
