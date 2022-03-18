//
//  HomeViewController.swift
//  CocktailProject
//
//  Created by ulas soyubey on 7.03.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let stackView = CocktailInformationStack()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        view.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false

    }
}
