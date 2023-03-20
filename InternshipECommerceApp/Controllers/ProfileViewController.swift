//
//  ProfileViewController.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 17.03.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let profileView = ProfileView()
    private let viewModel = ProfileViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.addSubview(profileView)
        profileView.delegate = self
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        view.safeAreaLayoutGuide.owningView?.backgroundColor = UIColor(hexString: "#FAF9FF")
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            profileView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
}

extension ProfileViewController: ProfileViewDelegate {
    func logOut() {
        let signIn = SignInViewController()
        signIn.modalTransitionStyle = .coverVertical
        signIn.modalPresentationStyle = .fullScreen
        present(signIn, animated: true)
    }
    
    func changeUserAvatar() {
        ImagePickerManager().pickImage(self) { [weak self] image in
            self?.profileView.userAvatarView.image = image
        }
    }
}
