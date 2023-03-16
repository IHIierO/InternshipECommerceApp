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

final class SignInViewViewModel {
    @Published var email = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var state: SignInStates = .none
    
    private var isValidEmailPublisher: AnyPublisher<Bool, Never> {
        $email
            .map {$0.isEmail}
            .eraseToAnyPublisher()
    }
    private var isValidFirstNamePublisher: AnyPublisher<Bool, Never> {
        $firstName
            .map {!$0.isBlank}
            .eraseToAnyPublisher()
    }
    private var isValidLastNamePublisher: AnyPublisher<Bool, Never> {
        $lastName
            .map {!$0.isBlank}
            .eraseToAnyPublisher()
    }
    public var isSignInEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(isValidEmailPublisher, isValidFirstNamePublisher, isValidLastNamePublisher)
            .map {$0 && $1 && $2}
            .eraseToAnyPublisher()
    }
    
    public func submitSignIn() {
        state = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            if strongSelf.isCorrectEmail(){
                print("\(strongSelf.isCorrectEmail())")
                strongSelf.state = .success
            } else {
                strongSelf.state = .failed
            }
        }
    }
    
    private func isCorrectEmail() -> Bool {
       return email != "test@mail.ru" 
    }
}
