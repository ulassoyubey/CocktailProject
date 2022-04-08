//
//  TopHeaderCollectionView.swift
//  CocktailProject
//
//  Created by ulas soyubey on 8.04.2022.
//

import UIKit
import SkeletonView

private let reuseIdentifier = "Cell"

class TopHeaderCollectionView: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var viewModel:TopHeaderViewModelProtocol!
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()

    
    init(viewModel:TopHeaderViewModel) {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        self.collectionView!.register(TopHeaderCollectionViewCell.self, forCellWithReuseIdentifier: TopHeaderCollectionViewCell.cellId)
        collectionView.isPagingEnabled = true
        view.addSubview(pageControl)
        configurePageControl()
        collectionView.isSkeletonable = true
        collectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .carrot), transition: .crossDissolve(0.25))
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchDrinks(searchedDrink: "vodka")
    }
    
    private func setLayout(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint) {
            self.pageControl.currentPage = visibleIndexPath.row
        }
    }
    
    private func configurePageControl(){
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print(viewModel.drinks.drinks.count)
        pageControl.numberOfPages = 5
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopHeaderCollectionViewCell.cellId, for: indexPath) as! TopHeaderCollectionViewCell
        if viewModel.drinks.drinks.count > 0 {
            cell.setCell(imageUrl: viewModel.drinks.drinks[indexPath.item].strDrinkThumb , drinkName: viewModel.drinks.drinks[indexPath.item].strDrink)
        }
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return .init(width: view.frame.width,height: view.frame.height)

    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DrinkDetailViewController()
        vc.drinkDetailVM = DrinkDetailViewModel(drink:
            viewModel.drinks.drinks[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension TopHeaderCollectionView:TopHeaderDelegate {
    func updateCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.stopSkeletonAnimation()
            self.collectionView.hideSkeleton(reloadDataAfter: false, transition: .crossDissolve(0.25))
        }
    }
}

extension TopHeaderCollectionView:SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return TopHeaderCollectionViewCell.cellId
    }
    
    
}
