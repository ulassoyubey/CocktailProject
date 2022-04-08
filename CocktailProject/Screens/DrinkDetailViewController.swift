//
//  DrinkDetailViewController.swift
//  CocktailProject
//
//  Created by ulas soyubey on 13.03.2022.
//

import UIKit

class DrinkDetailViewController: UIViewController, UIGestureRecognizerDelegate,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var drinkDetailVM: DrinkDetailViewModel! {
        didSet {
            drinkDetailVM.delegate = self
        }
    }
        
    private let verticalDivider:UIView = {
       let view = UIView()
        view.backgroundColor = .systemOrange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let informationStackView = CocktailInformationStack()
    
    private let mixButton = CocktailButton(title: "Start Mixing")
    
    private let collectionView:UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
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
        configureButton()
        configureCollectionView()
        drinkDetailVM.loadDrink()
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(openImage))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tabGesture)
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func configureHeaderLayout(){
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 450),
        ])
    }
    @objc private func openImage(){
        print("clicked")
        let vc = CocktailImageFullScreen(url: drinkDetailVM.strInstructions!)
            self.navigationController?.pushViewController(vc, animated: true)
    }
        
    private func configureNavbar(){
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .systemOrange
    }
    
    private func configureDummy(){
        view.addSubview(dummy)
        dummy.addSubview(cocktailName)
        dummy.addSubview(verticalDivider)
        dummy.addSubview(informationStackView)
        NSLayoutConstraint.activate([
            dummy.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dummy.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dummy.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dummy.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55),
            
            cocktailName.topAnchor.constraint(equalTo: dummy.topAnchor, constant: 10),
            cocktailName.centerXAnchor.constraint(equalTo: dummy.centerXAnchor),
            
            verticalDivider.heightAnchor.constraint(equalToConstant: 2),
            verticalDivider.topAnchor.constraint(equalTo: cocktailName.bottomAnchor, constant: 2),
            verticalDivider.centerXAnchor.constraint(equalTo: dummy.centerXAnchor),
            verticalDivider.widthAnchor.constraint(equalTo: cocktailName.widthAnchor),
            informationStackView.topAnchor.constraint(equalTo: verticalDivider.bottomAnchor, constant: 30),
            informationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),
            informationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0)
            
        ])
    }
    
    // MARK : Button Methods
    
    private func configureButton(){
        mixButton.addTarget(self, action: #selector(openRecipe), for: .touchUpInside)
        dummy.addSubview(mixButton)
        NSLayoutConstraint.activate([
            mixButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: 0),
            mixButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            mixButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            mixButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func openRecipe(){
        let sheetViewController = RecipeSheetController(recipe: drinkDetailVM.drink.strInstructions)
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
        collectionView.showsVerticalScrollIndicator = false
        dummy.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: informationStackView.topAnchor,constant: 60),
            collectionView.bottomAnchor.constraint(equalTo: mixButton.topAnchor,constant: -5),
            //collectionView.heightAnchor.constraint(equalToConstant: 270),
            collectionView.leadingAnchor.constraint(equalTo: dummy.leadingAnchor,constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: dummy.trailingAnchor,constant: -20)
        ])

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinkDetailVM.ingredientCount!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailIngredientCell.reuseId, for: indexPath) as! DetailIngredientCell
        cell.layer.cornerRadius = 16
        cell.set(drink: drinkDetailVM.drink.getIngredients()[indexPath.row].prepareUrlForIngredient(),measure: drinkDetailVM.drink.getMeasures()[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: (view.frame.width / 3) - 30, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let ingredientView = IngredientDetailViewController()
            ingredientView.viewModel = IngredientDetailViewModel(ingredientName: self.drinkDetailVM.drink.getIngredients()[indexPath.row].prepareUrlForIngredient())
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

extension DrinkDetailViewController:DrinkDetailDelegate {
    
    func setCocktailName(name:String) {
        cocktailName.text = name
    }

    func setHeaderData(drink:SearchDrink) {
        informationStackView.setData(drink: drink)
    }
    
    func setImage() {
        imageView.downloadImage(fromUrl: drinkDetailVM.drink.strDrinkThumb)
    }
}
