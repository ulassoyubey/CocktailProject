//
//  UIViewController+Ext.swift
//  CocktailProject
//
//  Created by ulas soyubey on 13.03.2022.
//

import UIKit

extension UIViewController {

func showToast(message : String, font: UIFont) {
    
    DispatchQueue.main.async {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-200, width: 300
                                               , height: 60))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(1)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 6.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
    }
} }
