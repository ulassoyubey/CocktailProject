//
//  FavoritesViewController.swift
//  CocktailProject
//
//  Created by ulas soyubey on 7.03.2022.
//

import UIKit

class FavoritesViewController: HasLoadingViewController {
    
    var drinksCollectionView:UICollectionView!
    
    var favoritesVM: FavoritesViewModel!
    
    init(viewModel:FavoritesViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.favoritesVM = viewModel
        favoritesVM.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureCollectionView()
        configureNavbar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCollectionViewConstrains()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        fetchFavorites()
    }
    
    private func fetchFavorites(){
        favoritesVM.fetchDrinks()
    }
    
    private func configureNavbar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemOrange]
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func configureCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        drinksCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(drinksCollectionView)
        drinksCollectionView.showsVerticalScrollIndicator = false
        drinksCollectionView.dataSource = self
        drinksCollectionView.delegate = self
        drinksCollectionView.alwaysBounceVertical = true
        self.drinksCollectionView.register(SquareDrinkCell.self, forCellWithReuseIdentifier: SquareDrinkCell.reuseId)
    }
    private func configureCollectionViewConstrains(){
        drinksCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            drinksCollectionView.topAnchor.constraint(equalTo: super.view.topAnchor),
            drinksCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            drinksCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            drinksCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -5)
        ])
    }
}


extension FavoritesViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesVM.favoritedDrinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = drinksCollectionView.dequeueReusableCell(withReuseIdentifier: SquareDrinkCell.reuseId, for: indexPath) as! SquareDrinkCell
        cell.setCell(imageUrl: favoritesVM.favoritedDrinks[indexPath.row].strDrinkThumb, drinkName: favoritesVM.favoritedDrinks[indexPath.row].strDrink)
        return cell
    }
    
    
}

extension FavoritesViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DrinkDetailViewController()
        vc.drinkDetailVM = DrinkDetailViewModel(drink:
        favoritesVM.favoritedDrinks[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FavoritesViewController:FavoritesDelegate {
    func startSpinner() {
        presentLoading()
    }
    
    func setCells() {
        drinksCollectionView.reloadData()
    }
    
    func endSpinner() {
        dismissLoading()
    }
}

extension FavoritesViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (view.frame.width / 2) - 40, height: 200)
    }
}
