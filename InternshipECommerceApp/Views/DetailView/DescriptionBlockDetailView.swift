//
//  DescriptionBlockDetailView.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 21.03.2023.
//

import UIKit

class DescriptionBlockDetailView: UIView {
    private let nameLabel = DefaultUILabel(inputText: "Reebok Classic Classiccccc", customFont: CustomFonts.montserratMedium, fontSize: 18, alingment: .left)
    private let priceLabel = DefaultUILabel(inputText: "$ 24", customFont: CustomFonts.montserratMedium, fontSize: 16, alingment: .right)
    private let descriptionLabel = DefaultUILabel(inputText: "Shoes inspired by 80s running shoes are still relevant today", customFont: CustomFonts.montserratRegular, fontSize: 14, colorForText: UIColor(hexString: "#808080"), alingment: .left)
    private let ratingLabel: UILabel = {
        let label = UILabel()
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "star")?.withTintColor(UIColor(hexString: "#F6C042"))
        attachment.bounds = CGRect(x: 0, y: 0, width: 16, height: 16)
        
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: CustomFonts.montserratRegular, size: 12.0) ]
        
        let imageString = NSMutableAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: "4.3 (4000 reviews)", attributes: myAttribute as [NSAttributedString.Key : Any])
        imageString.append(textString)
        
        label.attributedText = imageString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let colorsLabel = DefaultUILabel(inputText: "Color:", customFont: CustomFonts.montserratRegular, fontSize: 14, alingment: .left)
    private let colorsStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemTeal
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
            colorsStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            colorsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
