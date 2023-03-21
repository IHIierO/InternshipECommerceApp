//
//  DetailRootView.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 21.03.2023.
//

import UIKit

class DetailRootView: UIView {
    
    private let imagesBlockDetailView = ImagesBlockDetailView()
    private let descriptionBlockDetailView = DescriptionBlockDetailView()
    private let totalBlockDetailView = TotalBlockDetailView()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(imagesBlockDetailView, descriptionBlockDetailView, totalBlockDetailView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setConstraints(){
        NSLayoutConstraint.activate([
            imagesBlockDetailView.topAnchor.constraint(equalTo: topAnchor),
            imagesBlockDetailView.rightAnchor.constraint(equalTo: rightAnchor),
            imagesBlockDetailView.leftAnchor.constraint(equalTo: leftAnchor),
            imagesBlockDetailView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            descriptionBlockDetailView.topAnchor.constraint(equalTo: imagesBlockDetailView.bottomAnchor),
            descriptionBlockDetailView.rightAnchor.constraint(equalTo: rightAnchor),
            descriptionBlockDetailView.leftAnchor.constraint(equalTo: leftAnchor),
            descriptionBlockDetailView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25),
            
            totalBlockDetailView.topAnchor.constraint(equalTo: descriptionBlockDetailView.bottomAnchor, constant: 10),
            totalBlockDetailView.rightAnchor.constraint(equalTo: rightAnchor),
            totalBlockDetailView.leftAnchor.constraint(equalTo: leftAnchor),
            totalBlockDetailView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
