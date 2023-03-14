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
    var placeholderTextColor: UIColor
    
    init(placeholderText: String, placeholderTextColor: UIColor = .placeholderText){
        self.placeholderText = placeholderText
        self.placeholderTextColor = placeholderTextColor
        super.init(frame: .zero)
        
        attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderTextColor]
        )
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

