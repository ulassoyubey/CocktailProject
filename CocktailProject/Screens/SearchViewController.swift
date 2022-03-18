//
//  SearchViewController.swift
//  CocktailProject
//
//  Created by ulas soyubey on 7.03.2022.
//

import UIKit

class SearchViewController: HasLoadingViewController {
    
    enum Section {
        case main
    }
    
    var tableView = UITableView()
    var drinkDataSource = Drinks(drinks: [])
    var dataSource: UITableViewDiffableDataSource<Section,SearchDrink>!
    let searchBar = UISearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureCollectionView()
        searchDrink(searchValue: "margarita")
        configureDataSource()
        configureSearchController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func configureNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemOrange]
    }
    
    func configureCollectionView(){
        view.addSubview(tableView)
        tableView.frame = self.view.frame
        tableView.separatorColor = .clear
        tableView.backgroundColor = #colorLiteral(red: 0.9651457667, green: 0.9651457667, blue: 0.9651457667, alpha: 1)
        tableView.delegate = self
        tableView.register(DrinkCell.self, forCellReuseIdentifier: DrinkCell.reuseId)
    }

    func searchDrink(searchValue: String) {
        presentLoading()
        NetworkManager.shared.searchDrinks(drinkName: searchValue) { result in
            self.dismissLoading()
            switch result {
            case .success(let drinks):
                self.drinkDataSource = drinks
                self.updateData()
            case .failure(let error):
                self.showToast(message: "No Cocktail Found with given name", font: .systemFont(ofSize: 12))
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section,SearchDrink>(tableView: tableView, cellProvider: { (tableView, indexPath, itemIdentifier) ->UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: DrinkCell.reuseId, for: indexPath) as! DrinkCell
            cell.set(drink: itemIdentifier)
            cell.selectionStyle = .none
            return cell
        })
    }
    
    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section,SearchDrink>()
        snapshot.appendSections([.main])
        snapshot.appendItems(drinkDataSource.drinks)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search for a cocktail"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController = searchController
    }
    
}

extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DrinkDetailViewController(selectedDrink: drinkDataSource.drinks[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchDrink(searchValue: text.prepareSearchValueForUrl())
        }
    }
}

extension String {
    func prepareSearchValueForUrl() ->String {
        return self.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
    }
}
