//
//  CocktailBodyLabel.swift
//  CocktailProject
//
//  Created by ulas soyubey on 10.03.2022.
//

import UIKit

class CocktailBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat,textAligment:NSTextAlignment) {
        self.init(frame: .zero)
        
        self.textAlignment = textAligment
        self.font = UIFont(name:"HelveticaNeue-Bold", size: fontSize)
    }
    
    private func configure(){
        textColor = .systemOrange
        self.translatesAutoresizingMaskIntoConstraints = false
        lineBreakMode = .byTruncatingTail
    }

}
