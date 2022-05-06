//
//  RTextField.swift
//  Rapptr iOS Test
//
//  Created by Bryan Gomez on 5/2/22.
//

import UIKit

class RTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeHolder: String, isSecureText: Bool) {
        self.init(frame: .zero)
        set(placeHolder: placeHolder, isSecureText: isSecureText)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
            
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 5
        
        textColor = RColors.loginFilledTextColor
        tintColor = .label
        
        font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = RColors.viewBackgroundCOlor
        alpha = 0.40
        autocorrectionType = .no
        returnKeyType = .next
        clearButtonMode = .whileEditing
    }
    
    func set(placeHolder: String, isSecureText: Bool) {
        placeholder = placeHolder
        isSecureTextEntry = isSecureText
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: RColors.loginFilledTextColor ?? UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)])
    }
    
}
