//
//  SquaredDrinksCollectionView.swift
//  CocktailProject
//
//  Created by ulas soyubey on 9.04.2022.
//

import UIKit
import SkeletonView

class SquaredDrinksCollectionView: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var viewModel:PopularDrinksViewModelProtocol!
    
    init(viewModel:PopularDrinksViewModelProtocol) {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(SquareDrinkCell.self, forCellWithReuseIdentifier: SquareDrinkCell.reuseId)
        setLayout()
        collectionView.isSkeletonable = true
        collectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .carrot), transition: .crossDissolve(0.25))
        viewModel.fetchDrinks(searchedDrink: viewModel.drinkKeyword )
    }
    
    
    
    private func setLayout(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsVerticalScrollIndicator = false
        collectionView.setCollectionViewLayout(layout, animated: false)
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.drinks.drinks.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SquareDrinkCell.reuseId, for: indexPath)
        as! SquareDrinkCell
        if viewModel.drinks.drinks.count > 0 {
            cell.setCell(imageUrl: viewModel.drinks.drinks[indexPath.item].strDrinkThumb , drinkName: viewModel.drinks.drinks[indexPath.item].strDrink)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DrinkDetailViewController()
        vc.drinkDetailVM = DrinkDetailViewModel(drink:
            viewModel.drinks.drinks[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (view.frame.width / 2) - 40, height: 200)
    }
}

extension SquaredDrinksCollectionView:PopularDrinksViewModelDelegate {
    func updateCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.stopSkeletonAnimation()
            self.collectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        }
    }
}

extension SquaredDrinksCollectionView:SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return SquareDrinkCell.reuseId
    }
    
    
}
