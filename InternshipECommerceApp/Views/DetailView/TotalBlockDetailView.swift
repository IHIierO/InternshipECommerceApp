//
//  TotalBlockDetailView.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 21.03.2023.
//

import UIKit

class TotalBlockDetailView: UIView {
    
    private let quantityLabel = DefaultUILabel(inputText: "Quantity:", customFont: CustomFonts.montserratRegular, fontSize: 12, colorForText: UIColor(hexString: "#808080"), alingment: .left)
    private var quantityCount = 1
    public var price = 0
    private let quantityCountLabel = DefaultUILabel(inputText: "", customFont: CustomFonts.montserratMedium, fontSize: 15, colorForText: .white, alingment: .center)
    private let minusButton: UIButton = {
       let button = UIButton()
        button.configuration = .filled()
        button.configuration?.cornerStyle = .large
        button.configuration?.image = UIImage(systemName: "minus")?.applyingSymbolConfiguration(.init(scale: .small))
        button.configuration?.baseForegroundColor = UIColor(hexString: "#4E55D7")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let plusButton: UIButton = {
       let button = UIButton()
        button.configuration = .filled()
        button.configuration?.cornerStyle = .large
        button.configuration?.image = UIImage(systemName: "plus")?.applyingSymbolConfiguration(.init(scale: .small))
        button.configuration?.baseForegroundColor = UIColor(hexString: "#4E55D7")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    public let addToCartButton: UIButton = {
       let button = UIButton()
        button.configuration = .filled()
        button.configuration?.cornerStyle = .large
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: CustomFonts.montserratBold, size: 12)
            return outgoing
        }
        button.configuration?.baseForegroundColor = UIColor(hexString: "#4E55D7")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
        buttonsLogic()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupView
    private func setupView() {
        backgroundColor = UIColor(hexString: "#181726")
        clipsToBounds = true
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(quantityLabel, quantityCountLabel, minusButton, plusButton, addToCartButton)
        quantityCountLabel.text = String(describing: quantityCount)
        addToCartButton.configuration?.title = "# " + String(describing: price) + " " + "ADD TO CART"
    }
    
    // MARK: - buttonsLogic
    private func buttonsLogic() {
        minusButton.addTarget(self, action: #selector(minusTotalCount), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusTotalCount), for: .touchUpInside)
    }
    
    @objc private func minusTotalCount() {
        if quantityCount != 1 {
            quantityCount = quantityCount - 1
        } else {
            quantityCount = quantityCount - 0
        }
        quantityCountLabel.text = String(describing: quantityCount)
        addToCartButton.configuration?.title = "# " + String(describing: price * quantityCount) + " " + "ADD TO CART"
    }
    
    @objc private func plusTotalCount() {
        if quantityCount != 10 {
            quantityCount = quantityCount + 1
        } else {
            quantityCount = quantityCount + 0
        }
        quantityCountLabel.text = String(describing: quantityCount)
        addToCartButton.configuration?.title = "# " + String(describing: price * quantityCount) + " " + "ADD TO CART"
    }
    
    // MARK: - set constraints
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
