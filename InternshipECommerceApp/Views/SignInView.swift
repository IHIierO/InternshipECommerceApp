//
//  SignInView.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 13.03.2023.
//

import UIKit
import Combine

protocol SignInViewProtocol: AnyObject {
    func showLoginPage()
    func showTabBar()
}

class SignInView: UIView {
    
    private let viewModel = SignInViewViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    public weak var delegate: SignInViewProtocol?
    
    private let signInLabel: UILabel = {
       let label = UILabel()
        label.text = "Sign in"
        label.font = UIFont(name: CustomFonts.montserratMedium, size: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let firstNameTextField = DefaultUITextField(placeholderText: "First Name", placeholderTextColor: UIColor(hexString: "#7B7B7B"))
    private let lastNameTextField = DefaultUITextField(placeholderText: "Last Name", placeholderTextColor: UIColor(hexString: "#7B7B7B"))
    private let emailTextField = DefaultUITextField(placeholderText: "Email", placeholderTextColor: UIColor(hexString: "#7B7B7B"))
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
    private let validateLabel = DefaultUILabel(inputText: "", alingment: .center)
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
        addSubviews(signInLabel, firstNameTextField, lastNameTextField, emailTextField, signInButton, validateLabel, loginLabel, loginButton, signInWithGoogleButton, signInWithAppleButton)
        setConstraints()
        initialState()
        loginButton.addTarget(self, action: #selector(showLoginPage), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(showTabBar), for: .touchUpInside)
        signInWithGoogleButton.addTarget(self, action: #selector(showTabBar), for: .touchUpInside)
        signInWithAppleButton.addTarget(self, action: #selector(showTabBar), for: .touchUpInside)
        viewModel.delegate = self
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showLoginPage() {
        delegate?.showLoginPage()
    }
    
    @objc func showTabBar(sender: UIButton) {
        if sender == signInButton {
            viewModel.submitSignIn()
        } else {
            delegate?.showTabBar()
        }
    }
    
    private func initialState() {
        [firstNameTextField, lastNameTextField, emailTextField].forEach {
            $0.returnKeyType = .done
            $0.delegate = viewModel
            $0.backgroundColor = UIColor(hexString: "#E8E8E8")
            $0.textColor = UIColor(hexString: "#7B7B7B")
            $0.textAlignment = .center
            $0.font = UIFont(name: CustomFonts.montserratRegular, size: 14)
        }
        emailTextField.tag = 1
        validateLabel.isHidden = true
        signInButton.isEnabled = false
    }
    
    private func bindViewModel() {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: firstNameTextField)
            .map {
                guard let field = $0.object as? UITextField else {
                    return ""
                }
                guard let text = field.text else {
                    return ""
                }
                return text
            }
            .assign(to: \.firstName, on: viewModel)
            .store(in: &cancellables)
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: lastNameTextField)
            .map {
                guard let field = $0.object as? UITextField else {
                    return ""
                }
                guard let text = field.text else {
                    return ""
                }
                return text
            }
            .assign(to: \.lastName, on: viewModel)
            .store(in: &cancellables)
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: emailTextField)
            .map {
                guard let field = $0.object as? UITextField else {
                    return ""
                }
                guard let text = field.text else {
                    return ""
                }
                return text.lowercased()
            }
            .assign(to: \.email, on: viewModel)
            .store(in: &cancellables)
        
        viewModel.isSignInEnabled
            .assign(to: \.isEnabled, on: signInButton)
            .store(in: &cancellables)
        
        viewModel.$state
            .sink { [weak self] state in
                switch state {
                case .loading:
                    self?.validateLabel.isHidden = true
                    self?.signInButton.configurationUpdateHandler = { signInButton in
                        self?.signInButton.isEnabled = false
                        self?.signInButton.configuration?.showsActivityIndicator = true
                        self?.signInButton.configuration?.title = "Signing In..."
                    }
                case .success:
                    self?.delegate?.showTabBar()
                    self?.viewModel.saveUserData()
                case . failed:
                    self?.validateLabel.isHidden = false
                    self?.validateLabel.text = ValidationError.userDataAlreadyExist.errorsDiscription
                    self?.validateLabel.textColor = .red
                    self?.signInButton.configurationUpdateHandler = { signInButton in
                        self?.signInButton.configuration?.showsActivityIndicator = false
                        self?.signInButton.configuration?.title = "Sign in"
                    }
                case .none:
                    break
                }
            }
            .store(in: &cancellables)
    }
    
    private func setConstraints() {
        [signInLabel, firstNameTextField, lastNameTextField, emailTextField, signInButton, validateLabel,   signInWithGoogleButton, signInWithAppleButton].forEach {
            $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            $0.leftAnchor.constraint(equalTo: leftAnchor, constant: 43).isActive = true
            $0.rightAnchor.constraint(equalTo: rightAnchor, constant: -43).isActive = true
        }
        [firstNameTextField, lastNameTextField, emailTextField].forEach {
            $0.layer.cornerRadius = 14.5
            $0.heightAnchor.constraint(equalToConstant: 29).isActive = true
        }
        signInButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        NSLayoutConstraint.activate([
            signInLabel.topAnchor.constraint(equalTo: topAnchor, constant: 120),
            
            firstNameTextField.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 77),
            
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 35),
            
            emailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 35),
            
            signInButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 35),
            
            loginLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 17),
            loginLabel.leftAnchor.constraint(equalTo: signInButton.leftAnchor),
            
            loginButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 17),
            loginButton.leftAnchor.constraint(equalTo: loginLabel.rightAnchor),
            loginButton.heightAnchor.constraint(equalTo: loginLabel.heightAnchor),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            validateLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 13),
            
            signInWithGoogleButton.topAnchor.constraint(equalTo: validateLabel.bottomAnchor, constant: 70),
            
            signInWithAppleButton.topAnchor.constraint(equalTo: signInWithGoogleButton.bottomAnchor, constant: 48),
        ])
    }
}

extension SignInView: SignInViewViewModelDelegate {
    func hideValidationError() {
        validateLabel.isHidden = translatesAutoresizingMaskIntoConstraints
        validateLabel.text = ""
        validateLabel.textColor = .label
    }
    
    func showValidationError() {
        validateLabel.isHidden = false
        validateLabel.text = ValidationError.incorrectEmail.errorsDiscription
        validateLabel.textColor = .red
    }
}
