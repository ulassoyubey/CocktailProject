//
//  CategoriesCell.swift
//  CocktailProject
//
//  Created by ulas soyubey on 9.04.2022.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    
    static let reuseId = "categoryId"
    
    let avatarImageView = IngredientImageView(frame: .zero)
      let titleLabel = CocktailBodyLabel(fontSize: 17, textAligment: .left)
      
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
          addSubview(avatarImageView)
          addSubview(titleLabel)
          avatarImageView.contentMode = .scaleAspectFill
          titleLabel.textColor = .white
          
          NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor,constant: 5),
                avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -5),
                avatarImageView.widthAnchor.constraint(equalToConstant: frame.width / 3),
                
            //titleLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor,constant: 5),
            titleLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 0),
            //titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),

          ])
      }

    
}
