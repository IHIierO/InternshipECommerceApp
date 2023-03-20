//
//  UserDefaultsManager.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 20.03.2023.
//

import Foundation


final class UserDefaultsManager {
    
    enum ForSave: CaseIterable {
        case saveFirstName
        case saveLastName
        case saveEmail
    }
    static let share = UserDefaultsManager()
    
    private let defaults = UserDefaults.standard
    
    public func saveUserData(firstName: String, lastName: String, email: String) {
        guard !firstName.isBlank else {return}
        guard !lastName.isBlank else {return}
        guard !email.isBlank, email.isEmail else {return}
        
        defaults.set(firstName, forKey: "firstName")
        defaults.set(lastName, forKey: "lastName")
        defaults.set(email, forKey: "email")
    }
}
