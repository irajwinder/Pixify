//
//  Photo.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/4/23.
//

struct Photo: Codable {
    let id: String
    let urls: URLs
}

struct URLs: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

struct PhotoResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Photo]
}
