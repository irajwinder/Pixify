//
//  NetworkManager.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/4/23.
//

import Foundation

class NetworkManager : NSObject {
    
    static let sharedInstance : NetworkManager = {
        let instance = NetworkManager()
        return instance
    }()
    
    private override init() {
        super.init()
        
    }
    
    func searchPhotos(query: String, page: Int, completion: @escaping (PhotoResponse?) -> Void) {
        let apiUrl = "\(baseImageURL)/search/photos?query=\(query)&page=\(page)&client_id=\(clientID)"
        
        // 1. Get the url
        guard let requestURL = URL(string: apiUrl) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        // 2. Get the URLRequest
        var urlRequest = URLRequest(url: requestURL)
        // Sets cache policy and timeout interval for the request
        urlRequest.cachePolicy = .useProtocolCachePolicy
        urlRequest.timeoutInterval = 30.0
        urlRequest.httpMethod = "GET"
        
        //3. Make API request
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            // Decode JSON response
            let photoResponse = apiManagerInstance.decodePhotoResponse(data: data)
            completion(photoResponse)
        }
        task.resume()
    }
    
    func searchCollection(query: String, page: Int, completion: @escaping (CollectionResponse?) -> Void) {
        let apiUrl = "\(baseImageURL)/search/collections?query=\(query)&page=\(page)&client_id=\(clientID)"
        
        // 1. Get the url
        guard let requestURL = URL(string: apiUrl) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        // 2. Get the URLRequest
        var urlRequest = URLRequest(url: requestURL)
        // Sets cache policy and timeout interval for the request
        urlRequest.cachePolicy = .useProtocolCachePolicy
        urlRequest.timeoutInterval = 30.0
        urlRequest.httpMethod = "GET"
        
        //3. Make API request
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            // Decode JSON response
            let collectionResponse = apiManagerInstance.decodeCollectionResponse(data: data)
            completion(collectionResponse)
        }
        task.resume()
    }
    
    func CollectionPhotos(url: String, completion: @escaping ([Photo]?) -> Void) {
        // 1. Get the url
        guard let requestURL = URL(string: url) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        // 2. Get the URLRequest
        var urlRequest = URLRequest(url: requestURL)
        // Sets cache policy and timeout interval for the request
        urlRequest.cachePolicy = .useProtocolCachePolicy
        urlRequest.timeoutInterval = 30.0
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        
        //3. Make API request
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            // Decode JSON response
            let collectionPhotoResponse = apiManagerInstance.decodeCollectionPhotoResponse(data: data)
            completion(collectionPhotoResponse)
        }
        task.resume()
    }
    
    //download images from a given URL
    func downloadImage(from url: URL, completion: @escaping (Data?) -> Void) {
        // Create a data task to download the image from the given URL
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            // Pass data to the completion block
            completion(data)
        }
        // Resume the data task to start the download
        task.resume()
    }
}

let networkManagerInstance = NetworkManager.sharedInstance
