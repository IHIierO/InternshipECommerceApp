//
//  LogInViewController.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 13.03.2023.
//

import UIKit

class LogInViewController: UIViewController {

    private let logInView = LogInView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setConstraints()
    }
    
    private func setupController() {
        view.backgroundColor = .systemBackground
        view.addSubview(logInView)
        logInView.delegate = self
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logInView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logInView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            logInView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            logInView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension LogInViewController: LogInViewProtocol {
    func showTabBar() {
        let tabBar = TabBarController()
        tabBar.modalTransitionStyle = .crossDissolve
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
}
