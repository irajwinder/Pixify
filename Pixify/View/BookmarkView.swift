//
//  BookmarkView.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/6/23.
//

import SwiftUI

struct BookmarkView: View {
    @State private var bookmarks: [Bookmark] = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(bookmarks, id: \.self) { bookmark in
                    if let imageData = fileManagerClassInstance.loadImageDataFromFileManager(relativePath: bookmark.imageURL ?? "") {
                        Image(uiImage: UIImage(data: imageData)!)
                            .resizable()
                            .scaledToFill()
//                            .padding(.bottom, 10)
//                            .frame(width: 300, height: 200)
                    }
                }
                .onDelete(perform: deleteBookmark)
            }
            .onAppear {
                bookmarks = dataManagerInstance.fetchBookmark()
            }
            .navigationBarTitle("Bookmarks")
        }
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

#Preview {
    BookmarkView()
}

//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//#if os(iOS)
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//#endif
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
//
//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
