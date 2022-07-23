//
//  Filter.swift
//  TableView+Operation
//
//  Created by Artem Mushtakov on 23.07.2022.
//

import UIKit

/// Класс для применения фильтра к загруженному изображению
class FilterImageOperation: ImageTakeOperation {

    override public func main() {
        /// Всегда проверяем на завершение или отмену операции
        if isCancelled { return }
        guard let inputImage = inputImage else { return }
        if isCancelled { return }

        /// Применяем фильтр к изображению. (applySepiaFilter расширение для UiImage)
        outputImage = inputImage.applySepiaFilter()
    }
}
