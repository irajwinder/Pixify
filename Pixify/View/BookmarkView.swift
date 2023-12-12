//
//  BookmarkView.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/6/23.
//

import SwiftUI

struct BookmarkView: View {
    @StateObject private var stateObject = BookmarkIntent()

    var body: some View {
        NavigationStack {
            List {
                ForEach(stateObject.bookmarks, id: \.self) { bookmark in
                    if let imageData = fileManagerClassInstance.loadImageDataFromFileManager(relativePath: bookmark.imageURL ?? "") {
                        Image(uiImage: UIImage(data: imageData)!)
                            .resizable()
                            .frame(width: 300, height: 200)
                    }
                }
                .onDelete(perform: stateObject.deleteBookmark)
            }
            .onAppear {
                stateObject.fetchBookmarks()
            }
            .navigationBarTitle("Bookmarks")
        }
    }
}

#Preview {
    BookmarkView()
}
