//
//  CollectionPhotos.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/9/23.
//

import SwiftUI

struct CollectionPhotos: View {
    let selectedCollection: Collection
    @State private var collectionPhotoResponse: [Photo] = []
    
    @State private var showAlert = false
    @State private var alert: Alert?
    
    var body: some View {
        List {
            ForEach(collectionPhotoResponse, id: \.id) { photo in
                NavigationLink(destination: ImageDetailsView(photo: photo)) {
                    AsyncImage(url: URL(string: photo.urls.small)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 200)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                CustomBookmarkButton {
                    saveBookmark(photo: photo)
                }
            }
        }
        .padding()
        .onAppear {
            fetchCollectionPhotos()
        }
        .navigationBarTitle("Photos")
        .alert(isPresented: $showAlert) {
            alert!
        }
    }
    
    func fetchCollectionPhotos() {
        networkManagerInstance.CollectionPhotos(url: selectedCollection.links.photos) { response in
            guard let response = response else {
                print("Error getting photos")
                return
            }
            print("Total Photos: \(selectedCollection.total_photos)")
            collectionPhotoResponse = response
        }
    }
    
    func saveBookmark(photo: Photo) {
        guard let imageURL = URL(string: photo.urls.small) else {
            return
        }
        
        // Download image
        networkManagerInstance.downloadImage(from: imageURL) { imageData in
            guard let imageData = imageData else {
                return
            }
            // Save the image data to FileManager
            if let relativeURL = fileManagerClassInstance.saveImageToFileManager(imageData: imageData, photo: photo) {
                // Save the relative URL to CoreData
                dataManagerInstance.saveBookmark(imageURL: relativeURL)
            }
        }
        
        showAlert = true
        alert = Validation.showAlert(title: "Success", message: "Successfully save to Bookmark")
    }
}

//#Preview {
//    CollectionPhotos()
//}
