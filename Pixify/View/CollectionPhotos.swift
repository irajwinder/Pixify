//
//  CollectionPhotos.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/9/23.
//

import SwiftUI

struct CollectionPhotos: View {
    @StateObject private var stateObject = CollectionListIntent()
    var selectedCollection: Collection?
    
    @State private var showAlert = false
    @State private var alert: Alert?
    
    var body: some View {
        List {
            ForEach(stateObject.collectionPhotoResponse, id: \.id) { collectionPhoto in
                NavigationLink(destination: ImageDetailsView(photo: collectionPhoto)) {
                    LazyImage(url: URL(string: collectionPhoto.urls.small))
                }
                CustomBookmarkButton {
                    stateObject.saveBookmark(photo: collectionPhoto)
                    self.showAlert = true
                    self.alert = Validation.showAlert(title: "Success", message: "Successfully saved to Bookmark")
                }
            }
        }
        .padding()
        .onAppear {
            stateObject.fetchCollectionPhotos(url: selectedCollection?.links.photos ?? "")
        }
        .navigationBarTitle("Photos")
        .alert(isPresented: $showAlert) {
            alert!
        }
        .onAppear(perform: {
            print(selectedCollection?.total_photos)
        })
    }
}

#Preview {
    CollectionPhotos()
}
