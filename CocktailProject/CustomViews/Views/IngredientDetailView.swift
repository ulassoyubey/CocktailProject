//
//  IngredientDetailView.swift
//  CocktailProject
//
//  Created by ulas soyubey on 17.03.2022.
//

import UIKit

class IngredientDetailView: UIView {
    
    let mainView:UIView = {
       let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = .clear
        return view
    }()
    
    let containerView = UIView()
    var ingredientSource:Ingredient!
    let titleLabel = CocktailTitleLabel(fontSize: 30, textAligment: .center)
    let informationLabel = CocktailBodyLabel(fontSize: 20, textAligment: .center)
    let headerStackView = UIStackView()
    var imageViewUrl = ""
    let imageView = IngredientImageView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainView)
        configureView()
        configureHeaderTexts()
        configureImageView()
    }
    
    @objc func dissappearView(){
        print("clicked")
        removeFromSuperview()
    }
    
    convenience init(ingredientName:String) {
        self.init(frame: .zero)
        downloadData(ingName: ingredientName)
        self.imageView.downloadImage(fromUrl: ingredientName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView(){
        mainView.addSubview(containerView)
        containerView.layer.cornerRadius = 20
        containerView.backgroundColor = .systemGray6
        containerView.addSubview(headerStackView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 150),
            containerView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,constant: 30),
            containerView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,constant: -30),
            containerView.heightAnchor.constraint(equalToConstant: 600)
        ])

    }
    
    private func setInformationLabel(ingredient:Ingredient){
        DispatchQueue.main.async {
            self.titleLabel.text = self.ingredientSource.strIngredient
            self.informationLabel.text = self.ingredientSource.strType
        }
    }
    
    private func downloadData(ingName:String){
        NetworkManager.shared.searchIngredient(ingredientName: ingName) { result in
            switch result {
            case .success(let ingredient):
                self.ingredientSource = ingredient.ingredients[0]
                self.setInformationLabel(ingredient: self.ingredientSource)
            case .failure(let fail):
                print(fail)
            }
        }
    }
    
    private func configureHeaderTexts(){
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.alignment = .center
        headerStackView.axis = .vertical
        headerStackView.spacing = 10
        headerStackView.distribution = .equalSpacing
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(informationLabel)
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            headerStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    private func configureImageView(){
        containerView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 40),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -40),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}
