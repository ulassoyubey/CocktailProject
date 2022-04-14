//
//  SquareDrinkCell.swift
//  CocktailProject
//
//  Created by ulas soyubey on 9.04.2022.
//

import UIKit

class SquareDrinkCell: UICollectionViewCell {
    
    static let reuseId = "squareDrinkCell"

    let avatarImageView = TopHeaderImageView(frame: .zero)
      let titleLabel = CocktailBodyLabel(fontSize: 15, textAligment: .center)
      
    override init(frame: CGRect) {
         super.init(frame: frame)
         configure()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
      
    func setCell(imageUrl:String,drinkName:String){
        avatarImageView.downloadImage(fromUrl: imageUrl)
        titleLabel.text = drinkName
    }

      private func configure(){
          isSkeletonable = true
          addSubview(avatarImageView)
          avatarImageView.clipsToBounds = true
          avatarImageView.layer.cornerRadius = 20
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
