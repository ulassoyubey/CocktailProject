//
//  HomeHeaderCRV.swift
//  CocktailProject
//
//  Created by ulas soyubey on 8.04.2022.
//

import UIKit

class HomeHeaderCRV: UICollectionReusableView {
    
    let headerLabel = CocktailBodyLabel(fontSize: 20, textAligment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        headerLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
