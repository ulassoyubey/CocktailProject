//
//  CocktailImageFullScreen.swift
//  CocktailProject
//
//  Created by Kenan Ulaş Soyubey on 18.03.2022.
//

import UIKit

class CocktailImageFullScreen: UIViewController {
    
    let imageView = CocktailDetailImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        configureView()
        addTabGesture()
    }
    
    convenience init(url:String) {
        self.init(nibName: nil, bundle: nil)
        imageView.downloadImage(fromUrl: url)
    }
    
    private func addTabGesture(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        view.addGestureRecognizer(gesture)
        
    }
    
    @objc func dismissView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureView(){
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 450),
        ])
    }

}
