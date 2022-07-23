//
//  ImageOutputOperation.swift
//  TableView+Operation
//
//  Created by Artem Mushtakov on 23.07.2022.
//

import UIKit

class ImageOutputOperation: ImageTakeOperation {

    private let completion: (UIImage?) -> ()

    init(completion: @escaping (UIImage?) -> ()) {
        self.completion = completion
        super.init(image: nil)
    }

    override func main() {
        if isCancelled { completion(nil)}
        completion(inputImage)
    }
}
