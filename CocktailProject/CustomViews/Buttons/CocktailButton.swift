//
//  CocktailButton.swift
//  CocktailProject
//
//  Created by ulas soyubey on 17.03.2022.
//

import UIKit

class CocktailButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title:String) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
    }
    
    private func configureButton(){
        self.translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
        setTitleColor(.white, for: .normal)
        self.backgroundColor = .systemOrange
        self.setTitle("Click", for: .normal)
    }
}
