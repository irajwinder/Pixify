//
//  CollectionListIntent.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/12/23.
//

import SwiftUI

class CollectionListIntent: ObservableObject {
    @Published var collectionPhotoResponse: [Photo] = []
    
    func fetchCollectionPhotos(url: String) {
        networkManagerInstance.CollectionPhotos(url: url) { [weak self] response in
            guard let self = self, let response = response else {
                print("Error getting photos")
                return
            }
            DispatchQueue.main.async {
                self.collectionPhotoResponse.append(contentsOf: response)
            }
        }
    }
    
    func saveBookmark(photo: Photo) {
        guard let imageURL = URL(string: photo.urls.small) else {
            return
        }
        
        // Download image
        networkManagerInstance.downloadImage(from: imageURL) { [weak self] imageData in
            guard let self = self, let imageData = imageData else {
                return
            }
            // Save the image data to FileManager
            if let relativeURL = fileManagerClassInstance.saveImageToFileManager(imageData: imageData, photo: photo) {
                // Save the relative URL to CoreData
                dataManagerInstance.saveBookmark(imageURL: relativeURL)
            }
        }
    }
}
