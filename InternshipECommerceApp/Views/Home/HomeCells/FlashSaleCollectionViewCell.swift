//
//  FlashSaleCollectionViewCell.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 15.03.2023.
//

import UIKit

final class FlashSaleCollectionViewCell: UICollectionViewCell {
    static let reuseId = "FlashSaleCollectionViewCell"
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let salerAvatarImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "salerAvatar")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let categoryLabel = DefaultUILabel(inputText: "", customFont: CustomFonts.montserratMedium, fontSize: 11, alingment: .center)
    private let nameLabel = DefaultUILabel(inputText: "", customFont: CustomFonts.montserratBold, fontSize: 13, colorForText: .white, alingment: .left)
    private let priceLabel = DefaultUILabel(inputText: "", customFont: CustomFonts.montserratMedium,  fontSize: 10, colorForText: .white, alingment: .left)
    private let discountLabel = DefaultUILabel(inputText: "", customFont: CustomFonts.montserratBold, fontSize: 9, alingment: .center)
    
    private let addToCartButton: UIButton = {
       let button = UIButton()
        button.configuration = .borderless()
        button.configuration?.image = UIImage(named: "addToCart35x35")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let addToFavoriteButton: UIButton = {
       let button = UIButton()
        button.configuration = .borderless()
        button.configuration?.image = UIImage(named: "addToFavorite")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubviews(imageView, salerAvatarImageView, categoryLabel, nameLabel, priceLabel, discountLabel, addToCartButton, addToFavoriteButton)
        setupLayer()
        setConstraints()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        categoryLabel.text = nil
        nameLabel.text = nil
        priceLabel.text = nil
        discountLabel.text = nil
    }
    
    /// Configure cell
    /// - Parameter viewModel: cell viewModel
    func configure(with viewModel: FlashSaleCollectionViewCellViewModel) {
        categoryLabel.text = viewModel.categoryLabel
        nameLabel.text = viewModel.nameLabel
        priceLabel.text = viewModel.priceLabelText
        discountLabel.text = viewModel.discountLabelText
        viewModel.fethImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
    
    // MARK: - setupLayer
    private func setupLayer() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        categoryLabel.backgroundColor = UIColor(hexString: "#C4C4C4")
        categoryLabel.textColor = .black
        categoryLabel.edgeInset = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        categoryLabel.layer.cornerRadius = (contentView.frame.width * 0.1) / 2
        categoryLabel.layer.masksToBounds = true
        discountLabel.backgroundColor = .red
        discountLabel.textColor = .white
        discountLabel.edgeInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        discountLabel.layer.cornerRadius = (contentView.frame.width * 0.1) / 2
        discountLabel.layer.masksToBounds = true
        nameLabel.numberOfLines = 2
    }
    
    // MARK: - set constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            salerAvatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            salerAvatarImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            salerAvatarImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
            salerAvatarImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
            
            discountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            discountLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            
            addToCartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            addToCartButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            addToCartButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            addToCartButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            
            addToFavoriteButton.centerYAnchor.constraint(equalTo: addToCartButton.centerYAnchor),
            addToFavoriteButton.rightAnchor.constraint(equalTo: addToCartButton.leftAnchor, constant: -8),
            addToFavoriteButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            addToFavoriteButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            
            priceLabel.bottomAnchor.constraint(equalTo: addToCartButton.bottomAnchor),
            priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            priceLabel.rightAnchor.constraint(equalTo: addToFavoriteButton.leftAnchor, constant: -2),
            
            nameLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -10),
            nameLabel.leftAnchor.constraint(equalTo: priceLabel.leftAnchor),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            categoryLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -10),
            categoryLabel.leftAnchor.constraint(equalTo: priceLabel.leftAnchor),
        ])
    }
}

