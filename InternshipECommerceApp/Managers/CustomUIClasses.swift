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
//MARK: - DefaultUILabel
class DefaultUILabel: UILabel {
    
    let inputText: String
    let fontSize: CGFloat
    let alingment: NSTextAlignment
    let customFont: String
    let colorForText: UIColor
    var edgeInset: UIEdgeInsets = .zero
    
    init(inputText: String, customFont: String = "", fontSize: CGFloat = UIFont.systemFontSize, colorForText: UIColor = .label, alingment: NSTextAlignment){
        self.inputText = inputText
        self.fontSize = fontSize
        self.alingment = alingment
        self.customFont = customFont
        self.colorForText = colorForText
        super.init(frame: .zero)
        self.text = inputText
        self.textAlignment = alingment
        self.textColor = colorForText
        if customFont != "" {
            self.font = UIFont(name: customFont, size: fontSize)
        } else {
            self.font = .systemFont(ofSize: fontSize)
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: edgeInset.top, left: edgeInset.left, bottom: edgeInset.bottom, right: edgeInset.right)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + edgeInset.left + edgeInset.right, height: size.height + edgeInset.top + edgeInset.bottom)
    }
}
//MARK: - BackButton
class BackButton {
    var vc: UIViewController
    
    func createBackButton(){
        let backButton = UIBarButtonItem()
        backButton.tintColor = .black
        vc.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
   init(to vc: UIViewController){
        self.vc = vc
    }
}
