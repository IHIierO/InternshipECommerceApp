//
//  ProfileView.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 17.03.2023.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func changeUserAvatar()
    func logOut()
}

class ProfileView: UIView {
    
    public weak var delegate: ProfileViewDelegate?
    private let viewModel = ProfileViewViewModel()

    public let userAvatarView: UIImageView = {
       let avatarView = UIImageView()
        avatarView.image = UIImage(named: "userAvatar")
        avatarView.contentMode = .scaleAspectFill
        avatarView.layer.borderWidth = 1
        avatarView.layer.borderColor = UIColor(hexString: "#C0C0C0").cgColor
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        return avatarView
    }()
    private let userNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Satria Adhi Pradana"
        label.textAlignment = .center
        label.font = UIFont(name: CustomFonts.montserratSemiBold, size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let changePhotoButton: UIButton = {
       let button = UIButton()
        button.configuration = .borderless()
        button.configuration?.title = "Change photo"
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: CustomFonts.montserratLight, size: 10)
            return outgoing
        }
        button.configuration?.baseForegroundColor = UIColor(hexString: "#808080")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let uploadButton: UIButton = {
       let button = UIButton()
        button.configuration = .filled()
        button.configuration?.cornerStyle = .large
        button.configuration?.title = "Upload item"
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: CustomFonts.montserratRegular, size: 16)
            return outgoing
        }
        button.configuration?.image = UIImage(named: "uploadButtonImage")
        button.configuration?.imagePadding = 40
        button.configuration?.baseBackgroundColor = UIColor(hexString: "#4E55D7")
        button.configuration?.baseForegroundColor = UIColor(hexString: "#EAEAEA")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProfileMenuTableViewCell.self, forCellReuseIdentifier: ProfileMenuTableViewCell.reuseID)
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.separatorStyle = .none
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(hexString: "#FAF9FF")
        addSubviews(userAvatarView, userNameLabel, changePhotoButton, uploadButton, tableView)
        changePhotoButton.addTarget(self, action: #selector(changePhoto), for: .touchUpInside)
        setConstraints()
        viewModel.delegate = self
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func changePhoto() {
        delegate?.changeUserAvatar()
    }
    
    private func setConstraints() {
        [userAvatarView, userNameLabel, changePhotoButton, uploadButton].forEach {
            $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        }
        
        userAvatarView.layer.cornerRadius = 40
        userAvatarView.clipsToBounds = true
        userAvatarView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        userAvatarView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        NSLayoutConstraint.activate([
            userAvatarView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            
            changePhotoButton.topAnchor.constraint(equalTo: userAvatarView.bottomAnchor, constant: 5),
            
            userNameLabel.topAnchor.constraint(equalTo: changePhotoButton.bottomAnchor, constant: 5),
            userNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            userNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            userNameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            uploadButton.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 20),
            uploadButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            uploadButton.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: uploadButton.bottomAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension ProfileView: ProfileViewViewModelDelegate {
    func logOut() {
        delegate?.logOut()
    }
}
