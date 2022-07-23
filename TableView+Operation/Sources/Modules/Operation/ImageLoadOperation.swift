//
//  ImageLoadOperation.swift
//  TableView+Operation
//
//  Created by Artem Mushtakov on 23.07.2022.
//

import UIKit

/// Асинхронная операция загрузки изображения
class ImageLoadOperation: AsyncOperation {

    private var url: URL?
    private var outputImage: UIImage?

    init(url: URL?) {
        self.url = url
        super.init()
    }

    override func main() {
        /// Проверяем завершена ли операция
        if self.isCancelled { return }

        /// Операция завершена, производим новую загрузку изображения
        guard let imageURL = url else { return }
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if self.isCancelled { return }
            if let data = data,
                let imageData = UIImage(data: data) {
                if self.isCancelled { return }
                self.outputImage = imageData
            }
            self.state = .finished
        }
        task.resume()
    }
}

extension ImageLoadOperation: ImagePass {
    var image: UIImage? {
        return outputImage
    }
}
