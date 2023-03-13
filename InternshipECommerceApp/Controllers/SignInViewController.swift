//
//  SignInViewController.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 13.03.2023.
//

import UIKit

class SignInViewController: UIViewController {
    
    private let signInView = SignInView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setConstraints()
    }
    
    private func setupController() {
        view.backgroundColor = .systemBackground
        view.addSubview(signInView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            signInView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            signInView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            signInView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            signInView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    

}
