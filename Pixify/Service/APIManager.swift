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
}

let apiManagerInstance = APIManager.sharedInstance
