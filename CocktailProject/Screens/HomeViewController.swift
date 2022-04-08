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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTopView()
        configureCategoriesView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
        
    private func configureTopView(){
        view.addSubview(topView)
        let searchService:SearchService = NetworkManager()
        let topHeaderVM = TopHeaderViewModel(searchService: searchService)
        let topViewCollectionView = TopHeaderCollectionView(viewModel: topHeaderVM)
        self.add(childVC: topViewCollectionView, to: topView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: view.frame.height / 3)
        ])
    }
    
    private func configureCategoriesView(){
        view.addSubview(categoryView)
        
        let categoryVC = CategoriesCollectionView()
        self.add(childVC: categoryVC, to: categoryView)
        
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoryView.topAnchor.constraint(equalTo: topView.bottomAnchor,constant: 30),
            categoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryView.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
        ])
        
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

}
