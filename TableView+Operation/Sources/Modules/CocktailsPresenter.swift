//
//  CocktailsPresenter.swift
//  TableView+Operation
//
//  Created by Artem Mushtakov on 23.07.2022.
//

import UIKit
import Alamofire

protocol CocktailsViewInputProtocol: AnyObject {
    var model: CocktailsModel? { get set }

    init(view: CocktailsViewOutputProtocol, networkService: CocktailNetwork)

    func addLoadImage(willDisplay cell: UITableViewCell, indexPath: IndexPath)
    func removeProviderOperation(didEndDisplaying cell: UITableViewCell, indexPath: IndexPath)
}

class CocktailsPresenter: CocktailsViewInputProtocol {

    weak var view: CocktailsViewOutputProtocol?
    var model: CocktailsModel?

    private let networkService: CocktailNetwork
    private var imageProviders = Set<ImageProvider>()

    required init(view: CocktailsViewOutputProtocol, networkService: CocktailNetwork) {
        self.view = view
        self.networkService = networkService
        getCoctailsData()
    }

    private func getCoctailsData() {
        DispatchQueue.main.async {

            self.networkService.getCocktailNonAlcoholic { [weak self] getModel in
                guard let self = self else { return }
                self.model = getModel
                self.view?.succes()
            }
        }
    }

    func addLoadImage(willDisplay cell: UITableViewCell, indexPath: IndexPath) {
        guard let cell = cell as? CoctailsTableViewCell else { return }
        guard let imageUrlString = model?.drinks?[indexPath.row].strDrinkThumb else { return }

        /// Так как willDisplay вызывается непосредственно перед тем как ячейка появится на экране,
        /// создаем экземпляр ImageProvider для асинхронной обработки изображения(загрузки, применения фильтра)
        ///  Добовляем новый экземпляр в Set imageProviders, что бы в дальнейшем мы могли уничтожить неиспользуемые экземпляры.
        let imageProvider = ImageProvider(imageURLString: imageUrlString) { image in
            /// Вызываем обновление данных ячейки на main потоке, тк это Ui
            OperationQueue.main.addOperation {
                cell.updateImageViewWithImage(image)
            }
        }
        imageProviders.insert(imageProvider)
    }

    func removeProviderOperation(didEndDisplaying cell: UITableViewCell, indexPath: IndexPath) {
        guard let cell = cell as? CoctailsTableViewCell else { return }

        /// Уничтожаем экземпляры ImageProviders которые ушли с области видимости экрана,
        for provider in imageProviders.filter({ $0.imageURLString == cell.imageUrlIdentifier }) {
            provider.cancel()
            imageProviders.remove(provider)
        }
    }
}
