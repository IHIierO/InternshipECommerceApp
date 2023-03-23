//
//  SearchBarView.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 14.03.2023.
//

import UIKit

final class SearchBarView: UIView {
    
    private let searchTextField = DefaultUITextField(placeholderText: "What are you looking for ?", placeholderTextColor: UIColor(hexString: "#5B5B5B"))
    private let searchIcon: UIImageView = {
       let searchIcon = UIImageView()
        searchIcon.image = UIImage(named: "searchGlass")
        searchIcon.tintColor = UIColor(hexString: "#5B5B5B")
        searchIcon.contentMode = .scaleAspectFit
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        return searchIcon
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(searchTextField, searchIcon)
        setupSearchBar()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup SearchBar
    private func setupSearchBar() {
        searchTextField.layer.cornerRadius = 14.5
        searchTextField.backgroundColor = UIColor(hexString: "#F5F6F7")
        searchTextField.textColor = UIColor(hexString: "#5B5B5B")
        searchTextField.textAlignment = .center
        searchTextField.font = UIFont(name: CustomFonts.montserratRegular, size: 12)
        searchTextField.isEnabled = false
    }
    
    // MARK: - set constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: topAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            
            searchIcon.rightAnchor.constraint(equalTo: searchTextField.rightAnchor, constant: -15),
            searchIcon.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            searchIcon.heightAnchor.constraint(equalTo: searchTextField.heightAnchor, multiplier: 0.6),
            searchIcon.widthAnchor.constraint(equalTo: searchTextField.heightAnchor, multiplier: 0.6),
        ])
    }
}
