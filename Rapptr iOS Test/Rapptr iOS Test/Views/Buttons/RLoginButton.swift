//
//  RLoginButton.swift
//  Rapptr iOS Test
//
//  Created by Bryan Gomez on 5/2/22.
//

import UIKit

class RLoginButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        set(title: title)
    }
    
    func configure() {
        
        configuration = .filled()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(title: String) {
        configuration?.title = title
        
        configuration?.baseBackgroundColor = RColors.buttonColor
        configuration?.baseForegroundColor = UIColor.white
        
        configuration?.attributedTitle?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        configuration?.background.cornerRadius = 0
    }
}
