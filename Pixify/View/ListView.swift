//
//  ListView.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/4/23.
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

struct ListView: View {
    @StateObject private var stateObject = ImagesListIntent()
    @ObservedObject var observedObject: SearchImagesIntent
    
    var body: some View {
        List {
            ForEach(observedObject.photosResponse, id: \.id) { photo in
                NavigationLink(destination: ImageDetailsView(photo: photo)) {
                    AsyncImageView(url: URL(string: photo.urls.small))
                }
                CustomBookmarkButton {
                    stateObject.saveBookmark(photo: photo)
                }
            }
            
            ForEach(observedObject.collectionResponse, id: \.id) { collection in
                NavigationLink(destination: CollectionPhotos(selectedCollection: collection)) {
                    AsyncImageView(url: URL(string: collection.cover_photo.urls.small))
                }
            }
        }
        .navigationBarTitle(observedObject.selectedSearchType == .pictures ? "Photos" : "Collections")
        .alert(isPresented: $stateObject.showAlert) {
            stateObject.alert!
        }
    }
}

//#Preview {
//    ListView(observedObject: SearchImagesIntent())
//}

//struct ListView: View {
//    @Binding var photosResponse: [Photo]
//    @Binding var collectionResponse: [Collection]
//
//    @State private var showAlert = false
//    @State private var alert: Alert?
//
//    var selectedSearchType: SearchType
//    var navigationTitle: String {
//        return selectedSearchType == .pictures ? "Photos" : "Collections"
//    }
//
//    var body: some View {
//        List {
//            ForEach(photosResponse, id: \.id) { photo in
//                NavigationLink(destination: ImageDetailsView(photo: photo)) {
//                    AsyncImageView(url: URL(string: photo.urls.small))
//                }
//                CustomBookmarkButton {
//                    saveBookmark(photo: photo)
//                }
//            }
//
//            ForEach(collectionResponse, id: \.id) { collection in
//                NavigationLink(destination: CollectionPhotos(selectedCollection: collection)) {
//                    AsyncImageView(url: URL(string: collection.cover_photo.urls.small))
//                }
//            }
//        }
//        .navigationBarTitle(navigationTitle)
//        .alert(isPresented: $showAlert) {
//            alert!
//        }
//    }
//
//    func saveBookmark(photo: Photo) {
//        guard let imageURL = URL(string: photo.urls.small) else {
//            return
//        }
//
//        // Download image
//        networkManagerInstance.downloadImage(from: imageURL) { imageData in
//            guard let imageData = imageData else {
//                return
//            }
//            // Save the image data to FileManager
//            if let relativeURL = fileManagerClassInstance.saveImageToFileManager(imageData: imageData, photo: photo) {
//                // Save the relative URL to CoreData
//                dataManagerInstance.saveBookmark(imageURL: relativeURL)
//            }
//        }
//
//        showAlert = true
//        alert = Validation.showAlert(title: "Success", message: "Successfully save to Bookmark")
//    }
//}
