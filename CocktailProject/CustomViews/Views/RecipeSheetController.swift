//
//  RecipeSheetController.swift
//  CocktailProject
//
//  Created by ulas soyubey on 17.03.2022.
//

import UIKit

class RecipeSheetController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let titleLabel = CocktailTitleLabel(fontSize: 30, textAligment: .center)
    
    let tableView = UITableView()
    let recipeCell = "RecipeCell"

    
    var recipeText: [String] = []
    let imageView = UIImageView(image: UIImage(named: "shaker"))

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSheet()
        configureTitle()
        configureImage()
        configureTableView()
    }
    
    convenience init(recipe:String) {
        self.init(nibName: nil, bundle: nil)
        self.recipeText = recipe.components(separatedBy: ".").map({ str in
            str.trimmingCharacters(in: .whitespacesAndNewlines)
        }).filter { !$0.isEmpty }
        configureSheet()
        configureTitle()
        configureImage()
        configureTableView()        
    }
    
    private func configureTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: recipeCell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    private func configureSheet(){
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(tableView)
    }
    
    private func configureTitle(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "How To Mix ?"
        titleLabel.textColor = .systemOrange
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 10),
        ])
    }
    
    private func configureImage(){
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),

        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: recipeCell, for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(indexPath.row + 1).\(self.recipeText[indexPath.row])"
        return cell
    }
    

}
