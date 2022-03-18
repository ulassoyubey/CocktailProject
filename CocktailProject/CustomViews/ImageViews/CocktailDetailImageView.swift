//
//  CocktailDetailImageView.swift
//  CocktailProject
//
//  Created by ulas soyubey on 13.03.2022.
//

import UIKit

class CocktailDetailImageView: UIView {
    

    let imageView = UIImageView()

    let placeholderImage = UIImage(named: "avatar-placeholder")!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.image = placeholderImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 450)
            ]
        )
        
    }
        
    func downloadImage(fromUrl url: String){
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }

}
