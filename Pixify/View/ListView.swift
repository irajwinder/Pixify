//
//  ListView.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/4/23.
//

import SwiftUI

struct ListView: View {
    @Binding var photosResponse: [Photo]
    @Binding var collectionResponse: [Collection]
    
    var body: some View {
        List {
            ForEach(photosResponse, id: \.id) { photo in
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
        .navigationBarTitle("Photos List")
        .onAppear {
            for collection in collectionResponse {
                print("Title: \(collection.title)")
                print("Total Photos: \(collection.total_photos)")
                print("Cover Photo URL: \(collection.cover_photo.urls.regular)")
                print("HTML Link: \(collection.links.html)")
                print("\n")
            }
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
    }
}
