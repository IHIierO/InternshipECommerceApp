//
//  MenuItemCollectionViewCell.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 15.03.2023.
//

import UIKit

final class MenuItemCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "MenuItemCollectionViewCell"
    
    private let menuItemImageContainer: UIView = {
       let container = UIView()
        container.backgroundColor = UIColor(hexString: "#EEEFF4")
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private let menuItemImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let menuItemLabel = DefaultUILabel(inputText: "", customFont: CustomFonts.montserratLight, fontSize: 9, colorForText: UIColor(hexString: "#A6A7AB"), alingment: .center)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubviews(menuItemImageContainer, menuItemLabel)
        menuItemImageContainer.addSubview(menuItemImageView)
        setConstraints()
        setupContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        menuItemImageView.image = nil
        menuItemLabel.text = nil
    }
    
    public func configure(with model: MenuItems) {
        menuItemImageView.image = UIImage(named: model.image)
        menuItemLabel.text = model.name
    }
    
    private func setupContainer() {
        let width = contentView.frame.width * 0.7
        menuItemImageContainer.layer.cornerRadius = width/2
    }
    
    // MARK: - set constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            menuItemImageContainer.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            menuItemImageContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            menuItemImageContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            menuItemImageContainer.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            
            menuItemImageView.centerXAnchor.constraint(equalTo: menuItemImageContainer.centerXAnchor),
            menuItemImageView.centerYAnchor.constraint(equalTo: menuItemImageContainer.centerYAnchor),
            menuItemImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35),
            menuItemImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35),
            
            menuItemLabel.topAnchor.constraint(equalTo: menuItemImageContainer.bottomAnchor, constant: 5),
            menuItemLabel.leftAnchor.constraint(equalTo: leftAnchor),
            menuItemLabel.rightAnchor.constraint(equalTo: rightAnchor),
            menuItemLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
