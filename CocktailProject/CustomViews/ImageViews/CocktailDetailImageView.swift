//
//  CocktailDetailImageView.swift
//  CocktailProject
//
//  Created by ulas soyubey on 13.03.2022.
//

import UIKit

class CocktailDetailImageView: UICollectionReusableView {
    

    let imageView = UIImageView()
    
    var cocktailText:String!
    
    
    let containerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0
                                        , width: UIScreen.main.bounds.width, height: 450))
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
