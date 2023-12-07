//
//  DataManager.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/4/23.
//

import CoreData

//Singleton Class
class DataManager: NSObject {
    
    static let sharedInstance: DataManager = {
        let instance = DataManager()
        return instance
    }()
    
    private override init() {
        super.init()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Pixify")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()
    
    // Save Bookmark to CoreData
    func saveBookmark(imageURL: String) {
        // Access the view context from the persistent container
        let managedContext = persistentContainer.viewContext
        
        //Create a newBookMark Object
        let newBookmark = Bookmark(context: managedContext)
        // Set the values for attribute of the Bookmark entity
        newBookmark.imageURL = imageURL
        
        do {
            // Attempting to save the changes made to the managed context
            try managedContext.save()
        } catch let error as NSError {
            // Informs the user that an error occurred while saving the data.
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchBookmark() -> [Bookmark] {
        // Access the view context from the persistent container
        let managedContext = persistentContainer.viewContext
        
        do {
            // Fetch the bookmarks based on the fetch request
            return try managedContext.fetch(Bookmark.fetchRequest())
        } catch let error as NSError {
            // Handle the error
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    //Delete function for deleting entities
    func deleteEntity(_ entity: NSManagedObject) {
        // Access the view context from the persistent container
        let managedContext = persistentContainer.viewContext
        managedContext.delete(entity)
        
        do {
            // Attempting to save the changes made to the managed context
            try managedContext.save()
            print("\(entity.entity.name ?? "Entity") deleted successfully.")
        } catch let error as NSError {
            // Informs the user that an error occurred while saving the data.
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

let dataManagerInstance = DataManager.sharedInstance

