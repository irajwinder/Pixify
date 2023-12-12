//
//  Component.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/6/23.
//

import SwiftUI

struct CustomSearchField: View {
    var placeholder: String
    @Binding var searchText: String
    
    var body: some View {
        TextField(placeholder, text: $searchText)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .disableAutocorrection(true)
            .autocapitalization(.none)
    }
}

struct CustomSearchButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.blue)
                .imageScale(.large)
                .padding(8)
        }
    }
}

struct CustomBookmarkButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "bookmark")
                .foregroundColor(.blue)
                .imageScale(.large)
                .padding(8)
        }
    }
}

//Download image not AsyncImage
//Image lazy loading
//struct AsyncImageView: View {
//    var url: URL?
//    
//    var body: some View {
//        AsyncImage(url: url) { phase in
//            switch phase {
//            case .empty:
//                ProgressView()
//            case .success(let image):
//                image
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 300, height: 200)
//            case .failure:
//                Image(systemName: "photo")
//                    .resizable()
//                    .scaledToFit()
//                    .foregroundColor(.gray)
//            @unknown default:
//                EmptyView()
//            }
//        }
//    }
//}


struct LazyImage: View {
    @StateObject private var stateObject = LazyImageIntent()
    var url: URL?
    
    var body: some View {
        Image(uiImage: stateObject.image ?? UIImage(systemName: "photo")!)
            .resizable()
            .scaledToFit()
            .onAppear {
                if let url = url {
                    stateObject.loadImages(url: url)
                }
            }
    }
}
