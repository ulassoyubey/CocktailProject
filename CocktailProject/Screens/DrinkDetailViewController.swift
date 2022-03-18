//
//  DrinkDetailViewController.swift
//  CocktailProject
//
//  Created by ulas soyubey on 13.03.2022.
//

import UIKit

class DrinkDetailViewController: UIViewController, UIGestureRecognizerDelegate,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var drink: SearchDrink!
    
    private let informationStackView = CocktailInformationStack()
    
    private let mixButton = CocktailButton(title: "Start Mixing")
    
    private let collectionView:UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(DetailIngredientCell.self, forCellWithReuseIdentifier: DetailIngredientCell.reuseId)
        return collectionView
    }()
    
    
    let dummy:UIView = {
        let dummyView = UIView(frame: .zero)
        dummyView.translatesAutoresizingMaskIntoConstraints = false
        dummyView.backgroundColor = .white
        dummyView.layer.cornerRadius = 20
        return dummyView
    }()
    
    let imageView = CocktailDetailImageView(frame: .zero)
    
    let cocktailName = CocktailTitleLabel(fontSize: 20, textAligment: .center)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureHeaderLayout()
        configureDummy()
        configureNavbar()
        configureCollectionView()
        configureButton()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    convenience init(selectedDrink:SearchDrink) {
        self.init(nibName: nil, bundle: nil)
        self.drink = selectedDrink
    }
    
    private func configureHeaderLayout(){
        imageView.downloadImage(fromUrl: drink.strDrinkThumb)
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
        
    private func configureNavbar(){
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
    
    private func configureDummy(){
        view.addSubview(dummy)
        dummy.addSubview(cocktailName)
        dummy.addSubview(informationStackView)
        informationStackView.setData(drink: drink)
        cocktailName.text = drink.strDrink
        NSLayoutConstraint.activate([
            dummy.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dummy.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dummy.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dummy.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55),
            
            cocktailName.topAnchor.constraint(equalTo: dummy.topAnchor, constant: 10),
            cocktailName.centerXAnchor.constraint(equalTo: dummy.centerXAnchor),
            informationStackView.topAnchor.constraint(equalTo: cocktailName.topAnchor, constant: 60),
            informationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            informationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20)
            
        ])
    }
    
    // MARK : Button Methods
    
    private func configureButton(){
        mixButton.addTarget(self, action: #selector(openRecipe), for: .touchUpInside)
        dummy.addSubview(mixButton)
        NSLayoutConstraint.activate([
            mixButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20),
            mixButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            mixButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            mixButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func openRecipe(){
        let sheetViewController = RecipeSheetController(recipe: drink.strInstructions)
        if let sheetController = sheetViewController.sheetPresentationController {
            sheetController.detents = [.medium(), .large()]
            sheetController.preferredCornerRadius = 30
            sheetController.prefersGrabberVisible = true
        }
        present(sheetViewController, animated: true, completion: nil)
    }

    
    //CollectionView Methods
    
    private func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        dummy.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: informationStackView.topAnchor,constant: 40),
            collectionView.heightAnchor.constraint(equalToConstant: 190),
            collectionView.leadingAnchor.constraint(equalTo: dummy.leadingAnchor,constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: dummy.trailingAnchor,constant: -20)
        ])

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drink.getIngredients().count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailIngredientCell.reuseId, for: indexPath) as! DetailIngredientCell
        cell.layer.cornerRadius = 16
        cell.set(drink: drink.getIngredients()[indexPath.row].prepareUrlForIngredient(),measure: drink.getMeasures()[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: (view.frame.width / 3) - 30, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let ingredientView = IngredientDetailViewController(ingredientName: self.drink.getIngredients()[indexPath.row].prepareUrlForIngredient())
            ingredientView.modalPresentationStyle = .overCurrentContext
            self.present(ingredientView, animated: true, completion: nil)
        }
    }
}


extension String {
    func prepareUrlForIngredient() ->String {
        return self.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
    }
}
