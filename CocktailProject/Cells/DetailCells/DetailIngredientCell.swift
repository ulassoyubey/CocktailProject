//
//  DetailIngredientCell.swift
//  CocktailProject
//
//  Created by ulas soyubey on 15.03.2022.
//

import UIKit

class DetailIngredientCell: UICollectionViewCell {
    
    static let reuseId = "IngredientCell"

    let avatarImageView = IngredientImageView(frame: .zero)
      let titleLabel = CocktailBodyLabel(fontSize: 15, textAligment: .center)
      
    override init(frame: CGRect) {
         super.init(frame: frame)
         configure()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
      
    func set(drink:String,measure:String?){
        titleLabel.text = measure
        avatarImageView.downloadImage(fromUrl: drink)
      }
      
      private func configure(){
          isSkeletonable = true
          backgroundColor = .systemGray6
          addSubview(avatarImageView)
          addSubview(titleLabel)
          
          NSLayoutConstraint.activate([
                avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
                avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
                avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
                //avatarImageView.heightAnchor.constraint(equalToConstant: self.frame.width - 10),
                
                //titleLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor,constant: 5),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -3),
                avatarImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor,constant: -5)

          ])
      }

    
}
