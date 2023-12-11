//
//  Collection.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/8/23.
//

import Foundation

struct CollectionResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Collection]
}

struct Collection: Codable {
    let id: String
    let title: String
    let total_photos: Int
    let cover_photo: CoverPhoto
    let links: CollectionLinks
}

struct CoverPhoto: Codable {
    let id: String
    let urls: CoverPhotoURL
}

struct CoverPhotoURL: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

struct CollectionLinks: Codable {
    let photos: String
}
