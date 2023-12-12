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
    
    var body: some View {
        List {
            ForEach(stateObject.collectionPhotoResponse, id: \.id) { collectionPhoto in
                NavigationLink(destination: ImageDetailsView(photo: collectionPhoto)) {
                    LazyImage(url: URL(string: collectionPhoto.urls.small))
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
        .onAppear(perform: {
            print(selectedCollection?.total_photos)
        })
    }
}

#Preview {
    CollectionPhotos()
}
