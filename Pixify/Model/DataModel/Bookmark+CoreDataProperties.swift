//
//  Bookmark+CoreDataProperties.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/4/23.
//
//

import Foundation
import CoreData


extension Bookmark {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bookmark> {
        return NSFetchRequest<Bookmark>(entityName: "Bookmark")
    }

    @NSManaged public var imageURL: String?

}

extension Bookmark : Identifiable {

}
