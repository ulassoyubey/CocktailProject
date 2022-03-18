//
//  DrinkCell.swift
//  CocktailProject
//
//  Created by ulas soyubey on 10.03.2022.
//

import UIKit

class DrinkCell: UITableViewCell {

  static let reuseId = "DrinkCell"
    lazy var bgView:UIView = {
        let uiview = UIView(frame: CGRect(x: 20, y:5, width: UIScreen.main.bounds.width - 40, height: 100))
        uiview.backgroundColor = #colorLiteral(red: 0.9933353066, green: 0.9933351874, blue: 0.9933353066, alpha: 1)
        uiview.layer.cornerRadius = 20
        return uiview
    }()
    let avatarImageView = CocktailAvatarView()
    let titleLabel = CocktailTitleLabel(fontSize: 17, textAligment: .left)
    let informationLabel = CocktailBodyLabel(fontSize: 12, textAligment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(drink:SearchDrink){
        titleLabel.text = drink.strDrink
        informationLabel.text = drink.strGlass
        avatarImageView.downloadImage(fromUrl: drink.strDrinkThumb)
    }
    
    private func configure(){
        addSubview(bgView)
        backgroundColor = #colorLiteral(red: 0.9651457667, green: 0.9651457667, blue: 0.9651457667, alpha: 1)
        bgView.addSubview(titleLabel)
        bgView.addSubview(avatarImageView)
        bgView.addSubview(informationLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 10),
            
            titleLabel.topAnchor.constraint(equalTo: bgView.topAnchor,constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant:100),
            titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor,constant: -10),
            
            informationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 5),
            informationLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant:100),
            informationLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor,constant: -10)

        
        ])
    }
    
}
