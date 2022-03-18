//
//  HasLoadingViewController.swift
//  CocktailProject
//
//  Created by ulas soyubey on 12.03.2022.
//

import UIKit

class HasLoadingViewController: UIViewController {
    
    var containerView: UIView!
    let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func presentLoading(){
        containerView = UIView(frame: UIScreen.main.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemGray6
        containerView.alpha = 0.85

        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        activityIndicator.startAnimating()
    }    
    func dismissLoading(){
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }

}
