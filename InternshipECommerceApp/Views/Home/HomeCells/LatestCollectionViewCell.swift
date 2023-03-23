//
//  LatestCollectionViewCell.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 15.03.2023.
//

import UIKit

final class LatestCollectionViewCell: UICollectionViewCell {
    static let reuseId = "LatestCollectionViewCell"
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let categoryLabel = DefaultUILabel(inputText: "text", customFont: CustomFonts.montserratMedium, fontSize: 9, alingment: .center)
    private let nameLabel = DefaultUILabel(inputText: "text", customFont: CustomFonts.montserratBold, fontSize: 10, colorForText: .white, alingment: .left)
    private let priceLabel = DefaultUILabel(inputText: "text", customFont: CustomFonts.montserratMedium,  fontSize: 9, colorForText: .white, alingment: .left)
    
    private let addToCartButton: UIButton = {
       let button = UIButton()
        button.configuration = .borderless()
        button.configuration?.image = UIImage(named: "addToCart20x20")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubviews(imageView, categoryLabel, nameLabel, priceLabel, addToCartButton)
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
    }
    
    
    /// Configure cell
    /// - Parameter viewModel: cell viewModel
    func configure(with viewModel: LatestCollectionViewCellViewModel) {
        categoryLabel.text = viewModel.categoryLabel
        nameLabel.text = viewModel.nameLabel
        priceLabel.text = viewModel.priceLabelText
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
        categoryLabel.edgeInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        categoryLabel.layer.cornerRadius = (contentView.frame.width * 0.1) / 2
        categoryLabel.layer.masksToBounds = true
    }
    
    // MARK: - set constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            addToCartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            addToCartButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -4),
            addToCartButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            addToCartButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            
            priceLabel.bottomAnchor.constraint(equalTo: addToCartButton.bottomAnchor),
            priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            
            nameLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -10),
            nameLabel.leftAnchor.constraint(equalTo: priceLabel.leftAnchor),
            
            categoryLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -5),
            categoryLabel.leftAnchor.constraint(equalTo: priceLabel.leftAnchor),
        ])
    }
}
