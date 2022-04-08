//
//  IngredientImageView.swift
//  CocktailProject
//
//  Created by ulas soyubey on 15.03.2022.
//

import UIKit

class IngredientImageView: UIImageView {

    
    let placeholderImage = UIImage(named: "avatar-placeholder")!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        self.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .carrot), animation: nil, transition: .crossDissolve(0.25))
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        isSkeletonable = true
        clipsToBounds = true // sets the image to not have sharp corners in addition to the layer corner radius
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleToFill
    }
    
    func downloadImage(fromUrl ingredientName: String){
        let url = "https://www.thecocktaildb.com/images/ingredients/\(ingredientName)-Medium.png"
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image = image
                self.stopSkeletonAnimation()
                self.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.25))
            }
        }
    }
}
