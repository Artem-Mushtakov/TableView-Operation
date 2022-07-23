//
//  CocktailsModel.swift
//  TableView+Operation
//
//  Created by Artem Mushtakov on 23.07.2022.
//

import Foundation

struct CocktailsModel: Decodable {
    var drinks: [Drink]?
}

struct Drink: Decodable {
    var strDrink: String?
    var strDrinkThumb: String?
    var idDrink: String?
}
