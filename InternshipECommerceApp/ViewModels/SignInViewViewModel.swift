//
//  SignInViewViewModel.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 13.03.2023.
//

import UIKit
import Combine

enum SignInStates {
    case loading
    case success
    case failed
    case none
}

protocol SignInViewViewModelDelegate: AnyObject {
    func showValidationError()
    func hideValidationError()
}

final class SignInViewViewModel: NSObject {
    @Published var email: String = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var state: SignInStates = .none
    
    public weak var delegate: SignInViewViewModelDelegate?
    
    /// Checking email validation
    private var isValidEmailPublisher: AnyPublisher<Bool, Never> {
        $email
            .map {$0.isEmail}
            .eraseToAnyPublisher()
    }
    /// Checking firstName validation
    private var isValidFirstNamePublisher: AnyPublisher<Bool, Never> {
        $firstName
            .map {!$0.isBlank}
            .eraseToAnyPublisher()
    }
    /// Checking lastName validation
    private var isValidLastNamePublisher: AnyPublisher<Bool, Never> {
        $lastName
            .map {!$0.isBlank}
            .eraseToAnyPublisher()
    }
    /// Checking all validation condition
    public var isSignInEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(isValidEmailPublisher, isValidFirstNamePublisher, isValidLastNamePublisher)
            .map {$0 && $1 && $2}
            .eraseToAnyPublisher()
    }
    
    // MARK: - submit SignIn
    public func submitSignIn() {
        state = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            if strongSelf.isCorrectEmail(){
                strongSelf.state = .success
            } else {
                strongSelf.state = .failed
            }
        }
    }
    
    public func saveUserData() {
        UserDefaultsManager.share.saveUserData(firstName: firstName, lastName: lastName, email: email)
    }
    
    private func isCorrectEmail() -> Bool {
        return email != "test@mail.ru"
    }
}

// MARK: - UITextFieldDelegate
extension SignInViewViewModel: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            guard let text = textField.text else {return}
            if !text.isEmail {
                delegate?.showValidationError()
            } else {
                delegate?.hideValidationError()
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
