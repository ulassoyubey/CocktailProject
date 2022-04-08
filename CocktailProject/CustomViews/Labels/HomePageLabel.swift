//
//  HomePageLabel.swift
//  CocktailProject
//
//  Created by ulas soyubey on 8.04.2022.
//

import UIKit

class HomePageLabel: UILabel {

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
        self.font = UIFont(name:"Didot-Italic", size: fontSize)
    }
    
    private func configure(){
        textColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        lineBreakMode = .byTruncatingTail
    }

}
