//
//  IngredientDetailViewController.swift
//  CocktailProject
//
//  Created by ulas soyubey on 18.03.2022.
//

import UIKit

class IngredientDetailViewController: UIViewController {
    
    let containerView = UIScrollView()
    let wrapperView = UIView()
    let titleLabel = CocktailTitleLabel(fontSize: 30, textAligment: .center)
    let informationLabel = CocktailBodyLabel(fontSize: 20, textAligment: .center)
    let headerStackView = UIStackView()
    var imageViewUrl = ""
    let imageView = IngredientImageView(frame: .zero)
    let informationText = CocktailTitleLabel(fontSize: 15, textAligment: .center)
    
    var viewModel:IngredientViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2.withAlphaComponent(0.5)
        prepare()
        configureScrollView()
        configureWrapperView()
        configureHeaderTexts()
        configureImageView()
        addDissappearGesture()
        configureUILabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    
    
    // Disappearing
    private func addDissappearGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dissappearView))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dissappearView(){
        dismiss(animated: true, completion: nil)
    }

    
    private func prepare(){
        fetchData(ingName: viewModel.ingredientName ?? "")
        imageView.downloadImage(fromUrl: viewModel.ingredientName ?? "")
    }
    
    //View Configurations
    private func configureScrollView(){
        view.addSubview(containerView)
        containerView.addSubview(wrapperView)
        containerView.layer.cornerRadius = 20
        containerView.backgroundColor = .white
        containerView.addSubview(headerStackView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -40)
        ])

    }
    
    private func configureWrapperView(){
        wrapperView.addSubview(headerStackView)
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wrapperView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 1),
            wrapperView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            wrapperView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            wrapperView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -10)
        ])

    }
    
    private func fetchData(ingName:String){
        viewModel?.fetchIngredientDetail(ingName: ingName)
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
            headerStackView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 40),
            headerStackView.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor)
        ])
    }
    
    private func configureImageView(){
        wrapperView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor,constant: 40),
            imageView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor,constant: -40),
            imageView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func configureUILabel(){
        wrapperView.addSubview(informationText)
        informationText.numberOfLines = 0
        NSLayoutConstraint.activate([
            informationText.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            informationText.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 5),
            informationText.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -5),
            informationText.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor)
        ])
    }

}

extension IngredientDetailViewController:IngredientViewModelDelegate {
    func choosenIngredient(ingredientName: String) {
        viewModel.ingredientName = ingredientName
    }
    
    func setIngredientDetail(ingredient: Ingredients) {
        guard let vmIngredient = viewModel.ingredientSource else {return}
        DispatchQueue.main.async {
            self.titleLabel.text = vmIngredient.strIngredient
            self.informationLabel.text = vmIngredient.strType
            self.informationText.text = vmIngredient.strDescription
        }
    }
}
