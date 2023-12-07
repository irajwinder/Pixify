//
//  Photo.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/4/23.
//

import Foundation

//struct Photo: Codable {
//    let id: Int
//    let url: String
//    let src: PhotoSource
//}
//
//struct PhotoSource: Codable {
//    let original: String
//    let tiny: String
//}
//
//struct PhotoResponse: Codable {
//    let page: Int
//    let per_page: Int
//    let photos: [Photo]
//    let total_results: Int
//    let next_page: String?
//}

// Photo Struct
struct Photo: Codable {
    let id: String
    let urls: URLs
    //let links: Links
    
    struct URLs: Codable {
        let raw: String
        let full: String
        let regular: String
        let small: String
        let thumb: String
    }
    
//    struct Links: Codable {
//        let selfLink: String
//        let html: String
//        let download: String
//    }
}

// SearchResults Struct
struct PhotoResponse: Codable {
    let total: Int
    let totalPages: Int
    let results: [Photo]
}
