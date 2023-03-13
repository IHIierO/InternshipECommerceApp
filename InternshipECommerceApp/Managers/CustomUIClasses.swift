//
//  CustomUIClasses.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 13.03.2023.
//

import UIKit

//MARK: - DefaultUITextField
class DefaultUITextField: UITextField {
    
    var placeholderText: String
    
    init(placeholderText: String){
        self.placeholderText = placeholderText
        super.init(frame: .zero)
        
        self.placeholder = placeholderText
        //self.borderStyle = .roundedRect
        self.returnKeyType = .done
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func updatePlaceholder(newPlaceholderText: String){
        self.placeholder = newPlaceholderText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

