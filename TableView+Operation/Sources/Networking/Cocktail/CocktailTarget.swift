//
//  CocktailTarget.swift
//  TableView+Operation
//
//  Created by Artem Mushtakov on 23.07.2022.
//

import Moya
import Foundation

typealias CocktailTargetProvider = MoyaProvider<CocktailTargetType>

enum CocktailTargetType {
    case getCocktailNonAlcoholic
}

extension CocktailTargetType: TargetType {

    var baseURL: URL {
        switch self {
        case .getCocktailNonAlcoholic:
            return BaseUrl.allCocktail
        }
    }

    var path: String {
        switch self {
        case .getCocktailNonAlcoholic:
            return "/api/json/v1/1/filter.php"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getCocktailNonAlcoholic:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getCocktailNonAlcoholic:
            let parameters = ["a": "Non_Alcoholic"]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        switch self {
        case .getCocktailNonAlcoholic:
            return  ["API key": "1"]
        }
    }
}
