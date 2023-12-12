//
//  BookmarkIntent.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/12/23.
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
