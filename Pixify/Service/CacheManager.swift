//
//  CacheManager.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/7/23.
//

import Foundation

class CacheManager: NSObject {
    static let sharedInstance: CacheManager = {
        let instance = CacheManager()
        return instance
    }()
    
    private override init() {
        super.init()
        cache.countLimit = maxItemCount //50 images
    }
    
    // NSCache to store NSData objects with NSString keys
    var cache = NSCache<NSString, NSData>()
    let maxItemCount = 50
    
    // Retrieve an image data from the cache using a key
    func getImageData(forKey key: String) -> Data? {
        return cache.object(forKey: key as NSString) as? Data
    }
    
    // Store an image in the cache using a key
    func setImageData(_ imageData: Data, forKey key: String) {
        cache.setObject(imageData as NSData, forKey: key as NSString)
    }
}

let cacheManagerInstance = CacheManager.sharedInstance


//class ImageCache {
//    typealias CacheType = NSCache<NSString, NSData>
//    
//    static let shared = ImageCache()
//    
//    private init() {}
//    
//    private lazy var cache: CacheType = {
//        let cache = CacheType()
//        cache.countLimit = 100  //50 Images
//        cache.totalCostLimit = 50 * 1024 * 1024 //> 50 MB
//        return cache
//    }()
//    
//    // Retrieve an image data from the cache using a key
//    func getImageData(forKey key: String) -> Data? {
//        return cache.object(forKey: key as NSString) as? Data
//    }
//    
//    // Store an image in the cache using a key
//    func setImageData(_ imageData: Data, forKey key: String) {
//        cache.setObject(imageData as NSData, forKey: key as NSString)
//    }
//}
