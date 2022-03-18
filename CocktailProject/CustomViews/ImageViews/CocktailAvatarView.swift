//
//  CocktailAvatarView.swift
//  CocktailProject
//
//  Created by ulas soyubey on 10.03.2022.
//

import UIKit

class CocktailAvatarView: UIView {
    
    let imageView = UIImageView()
    
    let containerView: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 10, width: 80, height: 80))
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()

    let placeholderImage = UIImage(named: "avatar-placeholder")!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubview(containerView)
        imageView.frame = containerView.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.image = placeholderImage
        containerView.addSubview(imageView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
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
