//
//  CocktailInformationStack.swift
//  CocktailProject
//
//  Created by ulas soyubey on 17.03.2022.
//

import UIKit

class CocktailInformationStack: UIStackView {

    
    struct Constanst {
        static let titleFontSize:CGFloat = 15
        static let textAligment:NSTextAlignment = .center
        static let bodyFontSize:CGFloat = 12
    }
        
    let firstHorizontalDivider:UIView = {
       let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let secondHorizontalDivider:UIView = {
       let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let mainStackView = UIStackView()
    let glassStack = UIStackView()
    let drinkStack = UIStackView()
    let categoryStack = UIStackView()

    let glassTitle = CocktailTitleLabel(fontSize: Constanst.titleFontSize, textAligment: Constanst.textAligment)
    let drinkTypeTitle = CocktailTitleLabel(fontSize: Constanst.titleFontSize, textAligment: Constanst.textAligment)
    let categoryTitle = CocktailTitleLabel(fontSize: Constanst.titleFontSize, textAligment: Constanst.textAligment)
    let glassType = CocktailBodyLabel(fontSize: Constanst.bodyFontSize, textAligment: Constanst.textAligment)
    let drinkType = CocktailBodyLabel(fontSize: Constanst.bodyFontSize, textAligment: Constanst.textAligment)
    let category = CocktailBodyLabel(fontSize: Constanst.bodyFontSize, textAligment: Constanst.textAligment)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        configureGlassLabel()
        configureDrinkType()
        configureCategory()
        configureStackView()
        configureDivider()
    }
        
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(drink:SearchDrink){
        glassType.text = drink.strGlass
        category.text = drink.strCategory
        drinkType.text = drink.strAlcoholic
    }
    
    private func configureStackView(){
        addArrangedSubview(mainStackView)
        mainStackView.axis = .horizontal
        mainStackView.distribution = .equalSpacing
        mainStackView.alignment = .center
        mainStackView.addArrangedSubview(glassStack)
        mainStackView.addArrangedSubview(firstHorizontalDivider)
        mainStackView.addArrangedSubview(drinkStack)
        mainStackView.addArrangedSubview(secondHorizontalDivider)
        mainStackView.addArrangedSubview(categoryStack)
    }
    
    private func configureGlassLabel(){
        glassStack.distribution = .fill
        glassStack.axis = .vertical
        glassStack.spacing = 5
        glassStack.addArrangedSubview(glassTitle)
        glassStack.addArrangedSubview(glassType)
        glassTitle.text = "Glass Type"
        glassType.text = "Margarita Glass"
        glassType.numberOfLines = 0
        glassStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                glassType.trailingAnchor.constraint(equalTo: glassStack.trailingAnchor, constant: -5),
                glassType.leadingAnchor.constraint(equalTo: glassStack.leadingAnchor, constant: 5),
                glassStack.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width / 3 ) - 1)
            ]
        )
    }
    
    private func configureDrinkType(){
        drinkStack.distribution = .fill
        drinkStack.axis = .vertical
        drinkStack.spacing = 5
        drinkStack.addArrangedSubview(drinkTypeTitle)
        drinkStack.addArrangedSubview(drinkType)
        drinkTypeTitle.text = "Drink Type"
        drinkType.text = "Classical"
        
        NSLayoutConstraint.activate(
            [
                drinkStack.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width / 3 ) - 1)
            ]
        )
    }
    
    private func configureCategory(){
        categoryStack.distribution = .fill
        categoryStack.axis = .vertical
        categoryStack.spacing = 5
        categoryStack.addArrangedSubview(categoryTitle)
        categoryStack.addArrangedSubview(category)
        categoryTitle.text = "Category"
        category.text = "Classical"
        NSLayoutConstraint.activate(
            [
                categoryStack.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width / 3 ) - 1)
            ]
        )
    }
    
    
    private func configureDivider(){
        firstHorizontalDivider.translatesAutoresizingMaskIntoConstraints = false
        secondHorizontalDivider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstHorizontalDivider.widthAnchor.constraint(equalToConstant: 2),
            firstHorizontalDivider.heightAnchor.constraint(equalTo:mainStackView.heightAnchor),
            secondHorizontalDivider.widthAnchor.constraint(equalToConstant: 2),
            secondHorizontalDivider.heightAnchor.constraint(equalTo:mainStackView.heightAnchor)

        ])
    }

}
