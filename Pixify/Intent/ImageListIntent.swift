//
//  ImageListIntent.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/12/23.
//

import SwiftUI

class ImagesListIntent: ObservableObject {
    @Published var showAlert = false
    @Published var alert: Alert?
    
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
                // Update state to show the success alert
                DispatchQueue.main.async {
                    self.showAlert = true
                    self.alert = Validation.showAlert(title: "Success", message: "Successfully saved to Bookmark")
                }
            }
        }
    }
}
