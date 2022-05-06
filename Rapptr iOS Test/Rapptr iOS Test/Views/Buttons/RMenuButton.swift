//
//  RMenuButton.swift
//  Rapptr iOS Test
//
//  Created by Bryan Gomez on 4/29/22.
//

import UIKit

class RMenuButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init( title: String, image: String) {
        self.init(frame: .zero)
        set(title: title, image: image)
    }
    
    private func configure() {
        
        alpha = 0.80
        contentHorizontalAlignment = .left
        configuration = .filled()
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(title: String, image: String) {
        
        configuration?.contentInsets = .init(top: 0, leading: 22, bottom: 0, trailing: 0)
        
        configuration?.baseBackgroundColor = RColors.viewBackgroundCOlor
        configuration?.baseForegroundColor = RColors.menuTextColor
        configuration?.title = title
        configuration?.attributedTitle?.font = .systemFont(ofSize: 16, weight: .bold)
        
        
        configuration?.image = UIImage(named: image)
        configuration?.imagePadding = 16
        configuration?.imagePlacement = .leading
       
    }
}
