//
//  TopHeaderCollectionViewCell.swift
//  CocktailProject
//
//  Created by ulas soyubey on 8.04.2022.
//

import UIKit

class TopHeaderCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "topHeaderCell"
    
    private let fullImageView = TopHeaderImageView(frame: .zero)
    private let titleTextLabel = HomePageLabel(fontSize: 40, textAligment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(imageUrl:String,drinkName:String){
        fullImageView.downloadImage(fromUrl: imageUrl)
        titleTextLabel.text = drinkName
    }
    
    private func configureCell(){
        addSubview(fullImageView)
        addSubview(titleTextLabel)
        isSkeletonable = true
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        titleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fullImageView.topAnchor.constraint(equalTo: topAnchor),
            fullImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            fullImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fullImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleTextLabel.leadingAnchor.constraint(equalTo: fullImageView.leadingAnchor, constant: 15 ),
            titleTextLabel.bottomAnchor.constraint(equalTo: fullImageView.bottomAnchor, constant: -30)
        ])
    }
    
    
}
