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
    let urls: ImageURLs
    let links: PhotoLinks
}

struct ImageURLs: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

struct PhotoLinks: Codable {
    let selfLink: String
    let html: String
    let download: String
    
    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case html, download
    }
}

struct CollectionLinks: Codable {
    let selfLink: String
    let html: String
    let photos: String
    let related: String
    
    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case html, photos, related
    }
}

//{
//  "total": 237,
//  "total_pages": 12,
//  "results": [
//    {
//      "id": 193913,
//      "title": "Office",
//      "description": null,
//      "published_at": "2016-04-15T21:05:44-04:00",
//      "last_collected_at": "2016-06-02T13:10:03-04:00",
//      "updated_at": "2016-07-10T11:00:01-05:00",
//      "featured": true,
//      "total_photos": 60,
//      "private": false,
//      "share_key": "79ec77a237f014935eddc774f6aac1cd",
//      "cover_photo": {
//        "id": "pb_lF8VWaPU",
//        "created_at": "2015-02-12T18:39:43-05:00",
//        "width": 5760,
//        "height": 3840,
//        "color": "#1F1814",
//        "blur_hash": "L14Bk2M{0d^lR*j[ofWB0K%3^l9Y",
//        "likes": 786,
//        "liked_by_user": false,
//        "description": "A man drinking a coffee.",
//        "urls": {
//          "raw": "https://images.unsplash.com/photo-1423784346385-c1d4dac9893a",
//          "full": "https://hd.unsplash.com/photo-1423784346385-c1d4dac9893a",
//          "regular": "https://images.unsplash.com/photo-1423784346385-c1d4dac9893a?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&s=d60d527cb347746ab3abf5fccecf0271",
//          "small": "https://images.unsplash.com/photo-1423784346385-c1d4dac9893a?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&s=0bf0c97abca8b2741380f38d3debd45f",
//          "thumb": "https://images.unsplash.com/photo-1423784346385-c1d4dac9893a?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=9bc3a6d42a16809b735c22720de3fb13"
//        }
//      },
//      "links": {
//        "self": "https://api.unsplash.com/collections/193913",
//        "html": "http://unsplash.com/collections/193913/office",
//        "photos": "https://api.unsplash.com/collections/193913/photos",
//        "related": "https://api.unsplash.com/collections/193913/related"
//      }
//    },
//    // more collections...
//  ]
//}
