//
//  HomeViewController.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 13.03.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let homeView = HomeView()
    private let rightBarButtonView = RightBarButtonItemView()
    private let searchBarView = SearchBarView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        additionalSafeAreaInsets.top = 60
        setupNavigationItem()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setConstraints()
    }
    
    private func setupController() {
        view.backgroundColor = .systemBackground
        view.addSubviews(homeView, rightBarButtonView, searchBarView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            homeView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            rightBarButtonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -104),
            rightBarButtonView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            rightBarButtonView.widthAnchor.constraint(equalToConstant: 60),
            rightBarButtonView.heightAnchor.constraint(equalToConstant: 64),
            
            searchBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -4),
            searchBarView.heightAnchor.constraint(equalToConstant: 29),
            searchBarView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchBarView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    private func setupNavigationItem() {
        navigationController?.navigationBar.prefersLargeTitles = false
        view.safeAreaLayoutGuide.owningView?.backgroundColor = UIColor(hexString: "#FAF9FF")
        let titleText = "Trade by bata"
        let rangeForColor = (titleText as NSString).range(of: "bata")
        let rangeForSize = (titleText as NSString).range(of: titleText)
        let mutableAttributedString = NSMutableAttributedString.init(string: titleText)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: rangeForColor)
        mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 22, weight: .bold), range: rangeForSize)
        let title = UILabel()
        title.attributedText = mutableAttributedString
        navigationController?.navigationBar.topItem?.titleView = title
        let leftItem = UIBarButtonItem(image: UIImage(named: "leftNavMenu")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(openMenu))
        navigationItem.leftBarButtonItem = leftItem
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    @objc private func openMenu() {
        print("Menu is open")
    }
}

