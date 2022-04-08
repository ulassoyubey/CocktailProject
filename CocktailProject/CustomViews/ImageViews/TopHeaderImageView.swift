//
//  TopHeaderImageView.swift
//  CocktailProject
//
//  Created by ulas soyubey on 8.04.2022.
//

import UIKit

class TopHeaderImageView: UIImageView {

    //private let placeholderImage = UIImage(named: "avatar-placeholder")!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        clipsToBounds = true // sets the image to not have sharp corners in addition to the layer corner radius
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill
    }
    
    func downloadImage(fromUrl ingredientName: String){
        NetworkManager.shared.downloadImage(from: ingredientName) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }

}
