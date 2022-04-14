//
//  HomeViewController.swift
//  CocktailProject
//
//  Created by ulas soyubey on 7.03.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    let topView = UIView()
    let categoryView = UIView()
    let categoryLabel = CocktailBodyLabel(fontSize: 25, textAligment: .left)
    let popularDrinksLabel = CocktailBodyLabel(fontSize: 25, textAligment: .left)
    let popularDrinksView = UIView()
    let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureScrollView()
        configureTopView()
        configureCategoryLabel()
        configureCategoriesView()
        configurePopularDrinksLabel()
        configurePopularDrinks()
    }
    
    func configureScrollView(){
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollView.delegate = self
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true
    }
        
    private func configureTopView(){
        scrollViewContainer.addArrangedSubview(topView)
        let searchService:SearchService = NetworkManager()
        let topHeaderVM = TopHeaderViewModel(searchService: searchService)
        let topViewCollectionView = TopHeaderCollectionView(viewModel: topHeaderVM)
        self.add(childVC: topViewCollectionView, to: topView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor),
            topView.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: view.frame.height / 3)
        ])
    }
    
    private func configureCategoryLabel(){
        scrollViewContainer.addArrangedSubview(categoryLabel)
        categoryLabel.text = "Categories"
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: topView.bottomAnchor,constant: 30),
            categoryLabel.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 20)
        ])
    }
    
    private func configureCategoriesView(){
        scrollViewContainer.addArrangedSubview(categoryView)
        
        let categoryVC = CategoriesCollectionView()
        self.add(childVC: categoryVC, to: categoryView)
        
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoryView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor,constant: 15),
            categoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryView.heightAnchor.constraint(equalToConstant: view.frame.height / 17),
        ])
        
    }
    
    private func configurePopularDrinksLabel(){
        scrollViewContainer.addArrangedSubview(popularDrinksLabel)
        popularDrinksLabel.text = "Popular Drinks"
        NSLayoutConstraint.activate([
            popularDrinksLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    private func configurePopularDrinks(){
        scrollViewContainer.addArrangedSubview(popularDrinksView)
        popularDrinksView.backgroundColor = .black
        let searchServ:SearchService = NetworkManager()
        let popularVM = PopularDrinksViewModel(searchService: searchServ,drinkKeyword: "martini")
        let popularDrinksVC = SquaredDrinksCollectionView(viewModel: popularVM)
        self.add(childVC: popularDrinksVC, to: popularDrinksView)
        popularDrinksView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popularDrinksView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popularDrinksView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popularDrinksView.heightAnchor.constraint(equalToConstant: calculateEndingHeight(itemCount: 14)),
        ])
    }
    
    func calculateEndingHeight(itemCount:CGFloat) ->CGFloat {
        let totalItem: CGFloat = itemCount
        let totalCellInARow: CGFloat = 2
        let cellHeight: CGFloat = 200

        let collViewTopOffset: CGFloat = 20
        let collViewBottomOffset: CGFloat = 20

        let minLineSpacing: CGFloat = 10

        // calculations
        let totalRow = ceil(totalItem / totalCellInARow)
        let totalTopBottomOffset = collViewTopOffset + collViewBottomOffset
        let totalSpacing = CGFloat(totalRow - 1) * minLineSpacing   // total line space in UICollectionView is (totalRow - 1)
        let totalHeight  = (cellHeight * totalRow) + totalTopBottomOffset + totalSpacing

        return totalHeight
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

}

extension HomeViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0{
            //scrolling down
            changeTabBar(hidden: true, animated: true)
        }
        else{
            //scrolling up
            changeTabBar(hidden: false, animated: true)
        }
    }

    func changeTabBar(hidden:Bool, animated: Bool){
        let tabBar = self.tabBarController?.tabBar
        let offset = (hidden ? UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.height - (tabBar?.frame.size.height)! )
        if offset == tabBar?.frame.origin.y {return}
        print("changing origin y position")
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        UIView.animate(withDuration: duration,
                       animations: {tabBar!.frame.origin.y = offset},
                       completion:nil)
    }
}

