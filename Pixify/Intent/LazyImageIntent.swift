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
        // Check if the image is already in the cache
        if let imageData = cacheManagerInstance.getImageData(forKey: url.absoluteString) {
            print("Loading from cache")
            self.image = UIImage(data: imageData)
        } else {
            networkManagerInstance.downloadImage(from: url) { [weak self] imageData in
                guard let self = self, let imageData = imageData else {
                    return
                }
                DispatchQueue.main.async {
                    // Save the downloaded image to the cache
                    cacheManagerInstance.setImageData(imageData, forKey: url.absoluteString)
                    print("Downloading...")
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
}
