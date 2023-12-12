//
//  ListView.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/4/23.
//

import SwiftUI

struct ListView: View {
    @StateObject private var stateObject = ImagesListIntent()
    @ObservedObject var observedObject: SearchImagesIntent
    
    @State private var showAlert = false
    @State private var alert: Alert?
    
    var body: some View {
        List {
            ForEach(observedObject.photosResponse, id: \.id) { photo in
                NavigationLink(destination: ImageDetailsView(photo: photo)) {
                    LazyImage(url: URL(string: photo.urls.small))
                }
                CustomBookmarkButton {
                    stateObject.saveBookmark(photo: photo)
                    self.showAlert = true
                    self.alert = Validation.showAlert(title: "Success", message: "Successfully saved to Bookmark")
                }
                .onAppear(perform: {
                    // Check if the current photo is the last one
                    if photo.id == observedObject.photosResponse.last?.id {
                        // Load the next page when the last photo is reached
                        observedObject.currentPage += 1
                        observedObject.searchPhotos()
                        print(observedObject.currentPage)
                    }
                })
            }
            
            ForEach(observedObject.collectionResponse, id: \.id) { collection in
                NavigationLink(destination: CollectionPhotos(selectedCollection: collection)) {
                    LazyImage(url: URL(string: collection.cover_photo.urls.small))
                }
                .onAppear(perform: {
                    // Check if the current collection is the last one
                    if collection.id == observedObject.collectionResponse.last?.id {
                        // Load the next page when the last collection is reached
                        observedObject.currentPage += 1
                        observedObject.searchCollection()
                        print(observedObject.currentPage)
                    }
                })
            }
        }
        .navigationBarTitle(observedObject.selectedSearchType == .pictures ? "Photos" : "Collections")
        .alert(isPresented: $showAlert) {
            alert!
        }
    }
}

//#Preview {
//    ListView(observedObject: SearchImagesIntent())
//}
