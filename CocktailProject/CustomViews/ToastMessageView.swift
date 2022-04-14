//
//  ToastMessageView.swift
//  CocktailProject
//
//  Created by ulas soyubey on 15.04.2022.
//

import UIKit

class ToastMessageView: UIView {
    
    
    let toastLabel:UILabel = {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(1)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        return toastLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(text:String,color:UIColor) {
        self.init(frame: .zero)
        toastLabel.backgroundColor = color
        toastLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabelView(view:UIView){
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                toastLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
                toastLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                toastLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                toastLabel.heightAnchor.constraint(equalToConstant: 50)
            ]
        )
    }
    
    func presentToast(view:UIView){
        DispatchQueue.main.async {
            UIView.transition(with: view, duration: 0.20, options: [.transitionCrossDissolve], animations: {
                view.addSubview(self.toastLabel)
                self.configureLabelView(view: view)
            })
            UIView.animate(withDuration: 1, delay: 2.0, options: .curveEaseInOut, animations: {
                self.toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                self.toastLabel.removeFromSuperview()
            })
        }
        }
    }
