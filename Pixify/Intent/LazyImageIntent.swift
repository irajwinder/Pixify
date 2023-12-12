//
//  LazyImageIntent.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/11/23.
//

import SwiftUI

class LazyImageIntent: ObservableObject {
    @Published var image: UIImage?
    
    func loadImages(url: URL) {
        networkManagerInstance.downloadImage(from: url) { [weak self] imageData in
            guard let self = self, let imageData = imageData else {
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}
