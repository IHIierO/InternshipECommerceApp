//
//  LogInView.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 13.03.2023.
//

import UIKit
import Combine

protocol LogInViewProtocol: AnyObject {
    func showTabBar()
}

class LogInView: UIView {
    
    private let viewModel = LogInViewViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    public weak var delegate: LogInViewProtocol?
    
    private let logInLabel: UILabel = {
       let label = UILabel()
        label.text = "Welcome back"
        label.font = UIFont(name: CustomFonts.montserratMedium, size: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let firstNameTextField = DefaultUITextField(placeholderText: "First Name", placeholderTextColor: UIColor(hexString: "#7B7B7B"))
    private let passwordTextField = DefaultUITextField(placeholderText: "Password", placeholderTextColor: UIColor(hexString: "#7B7B7B"))
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
    private let validateLabel = DefaultUILabel(inputText: "", alingment: .center)

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubviews(logInLabel, firstNameTextField, passwordTextField, showPasswordButton, logInButton, validateLabel)
        passwordTextField.isSecureTextEntry = true
        logInButton.addTarget(self, action: #selector(showTabBar), for: .touchUpInside)
        showPasswordButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        setConstraints()
        initialState()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func showTabBar() {
        viewModel.submitLogIn()
    }
    
    @objc private func showPassword() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    private func initialState() {
        [firstNameTextField, passwordTextField].forEach {
            $0.backgroundColor = UIColor(hexString: "#E8E8E8")
            $0.textColor = UIColor(hexString: "#7B7B7B")
            $0.textAlignment = .center
            $0.font = UIFont(name: CustomFonts.montserratRegular, size: 14)
        }
        validateLabel.isHidden = true
        logInLabel.isEnabled = false
    }
    
    private func bindViewModel() {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: passwordTextField)
            .map {
                guard let field = $0.object as? UITextField else {
                    return ""
                }
                guard let text = field.text else {
                    return ""
                }
                return text
            }
            .assign(to: \.password, on: viewModel)
            .store(in: &cancellables)
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
        
        viewModel.isSignInEnabled
            .assign(to: \.isEnabled, on: logInButton)
            .store(in: &cancellables)
        
        viewModel.$state
            .sink { [weak self] state in
                switch state {
                case .loading:
                    self?.validateLabel.isHidden = true
                    self?.logInButton.configurationUpdateHandler = { logInButton in
                        self?.logInButton.isEnabled = false
                        self?.logInButton.configuration?.showsActivityIndicator = true
                        self?.logInButton.configuration?.title = "Log In..."
                    }
                case .success:
                    self?.delegate?.showTabBar()
                case . failed:
                    self?.validateLabel.isHidden = false
                    self?.validateLabel.text = ValidationError.incorrectNameOrPassword.errorsDiscription
                    self?.validateLabel.textColor = .red
                    self?.logInButton.configurationUpdateHandler = { logInButton in
                        self?.logInButton.configuration?.showsActivityIndicator = false
                        self?.logInButton.configuration?.title = "Login"
                    }
                case .none:
                    break
                }
            }
            .store(in: &cancellables)
    }
    
    private func setConstraints() {
        [logInLabel, firstNameTextField, passwordTextField, logInButton, validateLabel].forEach {
            $0.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            $0.leftAnchor.constraint(equalTo: leftAnchor, constant: 43).isActive = true
            $0.rightAnchor.constraint(equalTo: rightAnchor, constant: -43).isActive = true
        }
        [firstNameTextField, passwordTextField].forEach {
            $0.layer.cornerRadius = 14.5
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
            
            validateLabel.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 13),
        ])
    }
    
}

