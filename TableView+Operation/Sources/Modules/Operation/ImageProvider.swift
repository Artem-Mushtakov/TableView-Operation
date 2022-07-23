//
//  ImageProvider.swift
//  TableView+Operation
//
//  Created by Artem Mushtakov on 23.07.2022.
//

import UIKit

/// Класс очереди операций
class ImageProvider {

    private var operationQueue = OperationQueue ()
    let imageURLString: String

    init(imageURLString: String,completion: @escaping (UIImage?) -> ()) {
        self.imageURLString = imageURLString

        /// Указываем максимальное количество операций которые могут выполнятся в данной очереди
        operationQueue.maxConcurrentOperationCount = 2

        guard let imageURL = URL(string: imageURLString) else {return}

        /// Создаем операцию загрузки изображения
        let dataLoad = ImageLoadOperation(url: imageURL)

        /// Создаем операцию применения фильтра к изображению
        let filter = FilterImageOperation(image: nil)

        /// Создаем операцию получения готового изображения
        let output = ImageOutputOperation(completion: completion)

        /// Создаем массив операций
        let operations = [dataLoad, filter, output]

        /// Добавляем dependencies(зависимости) для операций, операция не запустится пока операции от которых она зависит, не завершатся.
        /// Операция filter зависит от загрузки изображения
        /// Операция output зависит от применения фильтра к изображению
        filter.addDependency(dataLoad)
        output.addDependency(filter)

        /// Добавляем операции в очередь
        /// Если waitUntilFinished true, то текущий поток будет блокироватся до тех пор, пока не завершатся все указанные операции.
        /// Если значение равно false, операции добавляются в очередь, и управление немедленно возвращается вызывающей стороне.
        /// Устанавливаем в false что бы не дожидатся завершения выполнения всех операций, в таком случае новые операции будут уже
        /// вставать очередь и ожидать разрешения на выполнение.
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }

    /// Отмена всех операций
    func cancel() {
        operationQueue.cancelAllOperations()
    }
}

/// Подписываемся на протокол Hashable, что бы в дальнейшем мы могли сравнивать обьекты ItemProvider, и также использовать его в Set.
extension ImageProvider: Hashable {
    var hashValue: Int {
        return (imageURLString).hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
}

func == (lhs: ImageProvider, rhs: ImageProvider) -> Bool {
    return lhs.imageURLString == rhs.imageURLString
}
