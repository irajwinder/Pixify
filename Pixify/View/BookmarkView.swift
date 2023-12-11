//
//  BookmarkView.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/6/23.
//

import SwiftUI

class BookmarkIntent: ObservableObject {
    @Published var bookmarks: [Bookmark] = []

    func fetchBookmarks() {
        bookmarks = dataManagerInstance.fetchBookmark()
    }

    func deleteBookmark(offsets: IndexSet) {
        for index in offsets {
            let bookmark = bookmarks[index]

            // Delete from FileManager
            fileManagerClassInstance.deleteImageFromFileManager(relativePath: bookmark.imageURL ?? "")

            // Delete from CoreData
            dataManagerInstance.deleteEntity(bookmark)
        }

        // Update the local array after deletion
        bookmarks.remove(atOffsets: offsets)
    }
}

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
