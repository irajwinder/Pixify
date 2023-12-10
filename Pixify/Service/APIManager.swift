//
//  APIManager.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/4/23.
//

import Foundation

class APIManager: NSObject {
    static let sharedInstance: APIManager = {
        let instance = APIManager()
        return instance
    }()
    
    private override init() {
        super.init()
    }
    
    // Decode Photo response
    func decodePhotoResponse(data: Data) -> PhotoResponse? {
        do {
            let decoder = JSONDecoder()
            let photoSearchResponse = try decoder.decode(PhotoResponse.self, from: data)
            return photoSearchResponse
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
            return nil
        }
    }
    
    // Decode Collection response
    func decodeCollectionResponse(data: Data) -> CollectionResponse? {
        do {
            let decoder = JSONDecoder()
            let collectionSearchResponse = try decoder.decode(CollectionResponse.self, from: data)
            return collectionSearchResponse
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
            return nil
        }
    }
    
    // Decode Collection Photo response
    func decodeCollectionPhotoResponse(data: Data) -> [Photo]? {
        do {
            let decoder = JSONDecoder()
            let collectionPhotoResponse = try decoder.decode([Photo].self, from: data)
            return collectionPhotoResponse
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
            return nil
        }
    }
}

let apiManagerInstance = APIManager.sharedInstance
