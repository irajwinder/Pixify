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

//{
//  "total": 237,
//  "total_pages": 12,
//  "results": [
//    {
//      "id": 193913,
//      "total_photos": 60,
//      "cover_photo": {
//        "id": "pb_lF8VWaPU",
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
//
//
//
//[
//    {
//        "id": "B7ZA7c6aPyM",
//        "urls": {
//            "raw": "https://images.unsplash.com/photo-1521927336940-cae6e9f22945?ixid=M3w1MzY2MDd8MHwxfGNvbGxlY3Rpb258MXwxOTM5MTN8fHx8fDJ8fDE3MDIyMzk0Mzh8&ixlib=rb-4.0.3",
//            "full": "https://images.unsplash.com/photo-1521927336940-cae6e9f22945?crop=entropy&cs=srgb&fm=jpg&ixid=M3w1MzY2MDd8MHwxfGNvbGxlY3Rpb258MXwxOTM5MTN8fHx8fDJ8fDE3MDIyMzk0Mzh8&ixlib=rb-4.0.3&q=85",
//            "regular": "https://images.unsplash.com/photo-1521927336940-cae6e9f22945?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzY2MDd8MHwxfGNvbGxlY3Rpb258MXwxOTM5MTN8fHx8fDJ8fDE3MDIyMzk0Mzh8&ixlib=rb-4.0.3&q=80&w=1080",
//            "small": "https://images.unsplash.com/photo-1521927336940-cae6e9f22945?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzY2MDd8MHwxfGNvbGxlY3Rpb258MXwxOTM5MTN8fHx8fDJ8fDE3MDIyMzk0Mzh8&ixlib=rb-4.0.3&q=80&w=400",
//            "thumb": "https://images.unsplash.com/photo-1521927336940-cae6e9f22945?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1MzY2MDd8MHwxfGNvbGxlY3Rpb258MXwxOTM5MTN8fHx8fDJ8fDE3MDIyMzk0Mzh8&ixlib=rb-4.0.3&q=80&w=200",
//            "small_s3": "https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1521927336940-cae6e9f22945"
//        }
//    },
//  //More photos
//]
//
