//
//  CocktailNetwork.swift
//  TableView+Operation
//
//  Created by Artem Mushtakov on 23.07.2022.
//

import Moya

protocol CocktailNetworkType {
    func getCocktailNonAlcoholic(complition: @escaping (CocktailsModel) -> ())
}

final class CocktailNetwork: CocktailNetworkType {

    private let cocktailTargetProvider: CocktailTargetProvider
    private var cocktailModel: CocktailsModel?

    init(cocktailTargetProvider: CocktailTargetProvider) {
        self.cocktailTargetProvider = cocktailTargetProvider
    }

    func getCocktailNonAlcoholic(complition: @escaping (CocktailsModel) -> ()) {
        cocktailTargetProvider.request(.getCocktailNonAlcoholic) { result in

            switch result {
            case .success(let response):
                guard let data = try? response.map(CocktailsModel.self) else { return }
                complition(data)
                print("Статус запроса: \(response.statusCode)")
            case .failure(let error):
                print(error)
            }
        }
    }
}
