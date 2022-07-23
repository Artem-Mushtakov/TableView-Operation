//
//  ModuleBuilder.swift
//  TableView+Operation
//
//  Created by Artem Mushtakov on 23.07.2022.
//

import UIKit

protocol Builder {
    static func createCoctailsModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createCoctailsModule() -> UIViewController {
        let view = CocktailsViewController()
        let networkService = CocktailNetwork(cocktailTargetProvider: .init())
        let presenter = CocktailsPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
}
