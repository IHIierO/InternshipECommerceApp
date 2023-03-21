//
//  ImagesBlockDetailView.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 21.03.2023.
//

import UIKit

class ImagesBlockDetailView: UIView {
    
    let imagesScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .systemCyan
        scrollView.isPagingEnabled = false
        scrollView.clipsToBounds = true
        scrollView.layer.cornerRadius = 12
        scrollView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let chooseImageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .systemMint
        scrollView.isPagingEnabled = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let menuStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor(hexString: "#E5E9EF")
        stackView.layer.cornerRadius = 10
        stackView.clipsToBounds = true
        stackView.alignment = .center
        stackView.distribution = .fillProportionally    
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let addToFavoriteButton: UIButton = {
       let button = UIButton()
        button.configuration = .borderless()
        button.configuration?.image = UIImage(named: "detailAddToFavorite")
        button.configuration?.baseForegroundColor = UIColor(hexString: "#545589")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let shareButton: UIButton = {
        let button = UIButton()
         button.configuration = .borderless()
         button.configuration?.image = UIImage(named: "share")
        button.configuration?.baseForegroundColor = UIColor(hexString: "#545589")
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        addSubviews(imagesScrollView, chooseImageScrollView, menuStackView)
        menuStackView.addArrangedSubview(addToFavoriteButton)
        menuStackView.addArrangedSubview(shareButton)
        menuStackView.addSeparators(color: UIColor(hexString: "#545589"))
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            imagesScrollView.topAnchor.constraint(equalTo: topAnchor),
            imagesScrollView.leftAnchor.constraint(equalTo: leftAnchor),
            imagesScrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: -60),
            imagesScrollView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            
            chooseImageScrollView.topAnchor.constraint(equalTo: imagesScrollView.bottomAnchor, constant: 10),
            chooseImageScrollView.leftAnchor.constraint(equalTo: leftAnchor),
            chooseImageScrollView.rightAnchor.constraint(equalTo: rightAnchor),
            chooseImageScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            menuStackView.centerXAnchor.constraint(equalTo: imagesScrollView.rightAnchor),
            menuStackView.bottomAnchor.constraint(equalTo: imagesScrollView.bottomAnchor, constant: -38),
            menuStackView.widthAnchor.constraint(equalToConstant: 45),
            menuStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
