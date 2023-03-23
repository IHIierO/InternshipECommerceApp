//
//  LogInViewViewModel.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 13.03.2023.
//

import UIKit
import Combine

enum LogInInStates {
    case loading
    case success
    case failed
    case none
}

final class LogInViewViewModel: NSObject {
    @Published var firstName = ""
    @Published var password = ""
    @Published var state: LogInInStates = .none
    
    /// Checking firstName validation
    private var isValidFirstNamePublisher: AnyPublisher<Bool, Never> {
        $firstName
            .map {!$0.isBlank}
            .eraseToAnyPublisher()
    }
    /// Checking password validation
    private var isValidPasswordPublisher: AnyPublisher<Bool, Never> {
        $password
            .map {$0.isValidPassword}
            .eraseToAnyPublisher()
    }
    /// Checking all validation condition
    public var isSignInEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isValidFirstNamePublisher, isValidPasswordPublisher)
            .map {$0 && $1}
            .eraseToAnyPublisher()
    }
    
    // MARK: - submit LogIn
    public func submitLogIn() {
        state = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            if strongSelf.isCorrectLogin(){
                strongSelf.state = .success
            } else {
                strongSelf.state = .failed
            }
        }
    }
    
    private func isCorrectLogin() -> Bool {
        guard let userFirstName = UserDefaults.standard.value(forKey: "firstName") as? String else {return false}
       return firstName == userFirstName && password == "123456Qwerty"
    }
}

// MARK: - UITextFieldDelegate
extension LogInViewViewModel: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
