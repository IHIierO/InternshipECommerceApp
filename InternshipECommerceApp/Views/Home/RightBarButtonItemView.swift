//
//  RightBarButtonItemView.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 14.03.2023.
//

import UIKit

final class RightBarButtonItemView: UIView {
    
    private let avatarView: UIImageView = {
       let avatarView = UIImageView()
        avatarView.image = UIImage(named: "rightNavAvatar")
        avatarView.contentMode = .scaleAspectFill
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        return avatarView
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let arrowView: UIImageView = {
       let arrowView = UIImageView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
        arrowView.image = UIImage(named: "locationArrow")
        arrowView.contentMode = .scaleAspectFit
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        return arrowView
    }()
    private let container: UIStackView = {
       let container = UIStackView()
        container.contentMode = .scaleAspectFit
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(avatarView, container)
        container.addArrangedSubview(label)
        container.addArrangedSubview(arrowView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: topAnchor),
            avatarView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            avatarView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            avatarView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            container.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 4),
            container.leftAnchor.constraint(equalTo: leftAnchor),
            container.rightAnchor.constraint(equalTo: rightAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
