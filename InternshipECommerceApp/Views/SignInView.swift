//
//  SignInView.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 13.03.2023.
//

import UIKit

protocol SignInViewProtocol: AnyObject {
    func showLoginPage()
    func showTabBar()
}

class SignInView: UIView {
    
    private let viewModel = SignInViewViewModel()
    
    public weak var delegate: SignInViewProtocol?
    
    private let signInLabel: UILabel = {
       let label = UILabel()
        label.text = "Sign in"
        label.font = UIFont(name: CustomFonts.montserratMedium, size: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let firstNameTextView = DefaultUITextField(placeholderText: "First Name")
    private let lastNameTextView = DefaultUITextField(placeholderText: "Last Name")
    private let emailTextView = DefaultUITextField(placeholderText: "Email")
    private let signInButton: UIButton = {
       let button = UIButton()
        button.configuration = .filled()
        button.configuration?.cornerStyle = .large
        button.configuration?.title = "Sign In"
        button.configuration?.baseBackgroundColor = UIColor(hexString: "#4E55D7")
        button.configuration?.baseForegroundColor = UIColor(hexString: "#EAEAEA")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let loginLabel: UILabel = {
       let label = UILabel()
        label.text = "Already have an account?"
        label.font = UIFont(name: CustomFonts.montserratLight, size: 11)
        label.textColor = UIColor(hexString: "#808080")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let loginButton: UIButton = {
       let button = UIButton()
        button.configuration = .borderless()
        button.configuration?.title = "Log In"
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: CustomFonts.montserratLight, size: 11)
            return outgoing
        }
        button.configuration?.baseForegroundColor = UIColor(hexString: "#254FE6")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let signInWithGoogleButton: UIButton = {
       let button = UIButton()
        button.configuration = .borderless()
        button.configuration?.imagePadding = 14
        button.configuration?.title = "Sign in with Google"
        button.configuration?.baseForegroundColor = .black
        button.configuration?.image = UIImage(named: "googleLogo")
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: CustomFonts.montserratLight, size: 16)
            return outgoing
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let signInWithAppleButton: UIButton = {
       let button = UIButton()
        button.configuration = .borderless()
        button.configuration?.imagePadding = 14
        button.configuration?.title = "Sign in with Apple"
        button.configuration?.baseForegroundColor = .black
        button.configuration?.image = UIImage(named: "appleLogo")
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: CustomFonts.montserratLight, size: 16)
            return outgoing
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubviews(signInLabel, firstNameTextView, lastNameTextView, emailTextView, signInButton, loginLabel, loginButton, signInWithGoogleButton, signInWithAppleButton)
        setConstraints()
        loginButton.addTarget(self, action: #selector(showLoginPage), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(showTabBar), for: .touchUpInside)
        signInWithGoogleButton.addTarget(self, action: #selector(showTabBar), for: .touchUpInside)
        signInWithAppleButton.addTarget(self, action: #selector(showTabBar), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showLoginPage() {
        delegate?.showLoginPage()
    }
    
    @objc func showTabBar(sender: UIButton) {
        if sender == signInWithGoogleButton || sender == signInWithAppleButton {
            delegate?.showTabBar()
        }
        if viewModel.checkValidate(for: emailTextView) {
            delegate?.showTabBar()
        } else {
            print("Incorrect email")
        }
    }
    
    private func setConstraints() {
        [signInLabel, firstNameTextView, lastNameTextView, emailTextView, signInButton,   signInWithGoogleButton, signInWithAppleButton].forEach {
            $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            $0.leftAnchor.constraint(equalTo: leftAnchor, constant: 43).isActive = true
            $0.rightAnchor.constraint(equalTo: rightAnchor, constant: -43).isActive = true
        }
        [firstNameTextView, lastNameTextView, emailTextView].forEach {
            $0.layer.cornerRadius = 14.5
            $0.backgroundColor = UIColor(hexString: "#E8E8E8")
            $0.textColor = UIColor(hexString: "#7B7B7B")
            $0.textAlignment = .center
            $0.font = UIFont(name: CustomFonts.montserratRegular, size: 14)
            $0.heightAnchor.constraint(equalToConstant: 29).isActive = true
        }
        signInButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        NSLayoutConstraint.activate([
            signInLabel.topAnchor.constraint(equalTo: topAnchor, constant: 120),
            
            firstNameTextView.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 77),
            
            lastNameTextView.topAnchor.constraint(equalTo: firstNameTextView.bottomAnchor, constant: 35),
            
            emailTextView.topAnchor.constraint(equalTo: lastNameTextView.bottomAnchor, constant: 35),
            
            signInButton.topAnchor.constraint(equalTo: emailTextView.bottomAnchor, constant: 35),
            
            loginLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 17),
            loginLabel.leftAnchor.constraint(equalTo: signInButton.leftAnchor),
            
            loginButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 17),
            loginButton.leftAnchor.constraint(equalTo: loginLabel.rightAnchor),
            loginButton.heightAnchor.constraint(equalTo: loginLabel.heightAnchor),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            signInWithGoogleButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 83),
            
            signInWithAppleButton.topAnchor.constraint(equalTo: signInWithGoogleButton.bottomAnchor, constant: 48),
        ])
    }
    
}
