//
//  LogInView.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 13.03.2023.
//

import UIKit

protocol LogInViewProtocol: AnyObject {
    func showTabBar()
}

class LogInView: UIView {
    
    private let viewModel = LogInViewViewModel()
    
    public weak var delegate: LogInViewProtocol?
    
    private let logInLabel: UILabel = {
       let label = UILabel()
        label.text = "Welcome back"
        label.font = UIFont(name: CustomFonts.montserratMedium, size: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let firstNameTextField = DefaultUITextField(placeholderText: "First Name")
    private let passwordTextField = DefaultUITextField(placeholderText: "Password")
    private let showPasswordButton: UIButton = {
       let button = UIButton()
        button.configuration = .borderless()
        button.configuration?.image = UIImage(named: "showPasswordButtonImage")
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let logInButton: UIButton = {
       let button = UIButton()
        button.configuration = .filled()
        button.configuration?.cornerStyle = .large
        button.configuration?.title = "Login"
        button.configuration?.baseBackgroundColor = UIColor(hexString: "#4E55D7")
        button.configuration?.baseForegroundColor = UIColor(hexString: "#EAEAEA")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubviews(logInLabel, firstNameTextField, passwordTextField, showPasswordButton, logInButton)
        passwordTextField.isSecureTextEntry = true
        logInButton.addTarget(self, action: #selector(showTabBar), for: .touchUpInside)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showTabBar() {
        delegate?.showTabBar()
    }
    
    private func setConstraints() {
        [logInLabel, firstNameTextField, passwordTextField, logInButton].forEach {
            $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            $0.leftAnchor.constraint(equalTo: leftAnchor, constant: 43).isActive = true
            $0.rightAnchor.constraint(equalTo: rightAnchor, constant: -43).isActive = true
        }
        [firstNameTextField, passwordTextField].forEach {
            $0.layer.cornerRadius = 14.5
            $0.backgroundColor = UIColor(hexString: "#E8E8E8")
            $0.textColor = UIColor(hexString: "#7B7B7B")
            $0.textAlignment = .center
            $0.font = UIFont(name: CustomFonts.montserratRegular, size: 14)
            $0.heightAnchor.constraint(equalToConstant: 29).isActive = true
        }
        logInButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        NSLayoutConstraint.activate([
            logInLabel.topAnchor.constraint(equalTo: topAnchor, constant: 120),
            
            firstNameTextField.topAnchor.constraint(equalTo: logInLabel.bottomAnchor, constant: 77),
            
            passwordTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 35),
            
            showPasswordButton.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor, constant: -7),
            showPasswordButton.topAnchor.constraint(equalTo: passwordTextField.topAnchor),
            showPasswordButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor),
            showPasswordButton.widthAnchor.constraint(equalTo: passwordTextField.heightAnchor),
            
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 99),
            
        ])
    }
    
}

