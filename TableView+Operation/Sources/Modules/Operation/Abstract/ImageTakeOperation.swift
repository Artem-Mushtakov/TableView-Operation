//
//  ImageTakeOperation.swift
//  TableView+Operation
//
//  Created by Artem Mushtakov on 23.07.2022.
//

import UIKit

/// Протокол передачи изображения
protocol ImagePass {
    var image: UIImage? { get }
}

/// Это абстрактная операция которая извелекает изображение из зависимостей, в случае если оно не переданно в инициализатор
class ImageTakeOperation: Operation {

    var outputImage: UIImage?
    let _inputImage: UIImage?

    init(image: UIImage?) {
        self._inputImage = image
        super.init()
    }

    var inputImage: UIImage? {
        var image: UIImage?
        if let inputImage = _inputImage {
            image = inputImage
        } else if let dataProvider = dependencies
            .filter({ $0 is ImagePass })
            .first as? ImagePass {
            image = dataProvider.image
        }
        return image
    }
}

/// Подписываемя под протокол для получения готового изображения
extension ImageTakeOperation: ImagePass {
    var image: UIImage? {
        return outputImage
    }
}
