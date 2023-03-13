//
//  SignInViewViewModel.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 13.03.2023.
//

import UIKit

final class SignInViewViewModel {
    init() {
        
    }
    
    func checkValidate(for email: UITextField) -> Bool {
        
        guard let emailString = email.text else {
            return false
        }
        
        if emailString.isEmail {
            print("Is validate")
            return true
        } else {
            print("Is't validate")
            return false
        }
    }
}
