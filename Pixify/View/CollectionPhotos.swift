//
//  CollectionPhotos.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/9/23.
//

import SwiftUI

class CollectionListIntent: ObservableObject {
    @Published var collectionPhotoResponse: [Photo] = []
    @Published var showAlert = false
    @Published var alert: Alert?
    
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
            
            self.showAlert = true
            self.alert = Validation.showAlert(title: "Success", message: "Successfully saved to Bookmark")
        }
    }
}

struct CollectionPhotos: View {
    @StateObject private var stateObject = CollectionListIntent()
    var selectedCollection: Collection?
    
    var body: some View {
        List {
            ForEach(stateObject.collectionPhotoResponse, id: \.id) { collectionPhoto in
                NavigationLink(destination: ImageDetailsView(photo: collectionPhoto)) {
                    AsyncImageView(url: URL(string: collectionPhoto.urls.small))
                }
                CustomBookmarkButton {
                    stateObject.saveBookmark(photo: collectionPhoto)
                }
            }
        }
        .padding()
        .onAppear {
            stateObject.fetchCollectionPhotos(url: selectedCollection?.links.photos ?? "")
        }
        .navigationBarTitle("Photos")
        .alert(isPresented: $stateObject.showAlert) {
            stateObject.alert!
        }
    }
}

#Preview {
    CollectionPhotos()
}

//struct CollectionPhotos: View {
//    var selectedCollection: Collection?
//    @State private var collectionPhotoResponse: [Photo] = []
//    
//    @State private var showAlert = false
//    @State private var alert: Alert?
//    
//    var body: some View {
//        List {
//            ForEach(collectionPhotoResponse, id: \.id) { collectionPhoto in
//                NavigationLink(destination: ImageDetailsView(photo: collectionPhoto)) {
//                    AsyncImageView(url: URL(string: collectionPhoto.urls.small))
//                }
//                CustomBookmarkButton {
//                    saveBookmark(photo: collectionPhoto)
//                }
//            }
//        }
//        .padding()
//        .onAppear {
//            fetchCollectionPhotos()
//        }
//        .navigationBarTitle("Photos")
//        .alert(isPresented: $showAlert) {
//            alert!
//        }
//    }
//    
//    func fetchCollectionPhotos() {
//        networkManagerInstance.CollectionPhotos(url: selectedCollection?.links.photos ?? "") { response in
//            guard let response = response else {
//                print("Error getting photos")
//                return
//            }
//            print("Total Photos: \(selectedCollection?.total_photos ?? 0)")
//            collectionPhotoResponse = response
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
