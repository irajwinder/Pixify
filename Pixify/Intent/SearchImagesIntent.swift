//
//  SearchImagesIntent.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/8/23.
//

import SwiftUI

//If not o
class SearchImagesIntent: ObservableObject {
    @Published var currentPage = 1
    @Published var photosResponse: [Photo] = []
    @Published var collectionResponse: [Collection] = []
    
    @Published var searchText = ""
    @Published var selectedSearchType = SearchType.pictures
    
    func searchPhotos() {
        networkManagerInstance.searchPhotos(query: searchText, page: currentPage) { [weak self] response in
            guard let self = self, let response = response?.results else {
                print("Failed to fetch photos")
                return
            }
            DispatchQueue.main.async {
                self.photosResponse.append(contentsOf: response)
            }
        }
    }
    
    func searchCollection() {
        networkManagerInstance.searchCollection(query: searchText, page: currentPage) { [weak self] response in
            guard let self = self, let response = response?.results else {
                print("Failed to fetch collections")
                return
            }
            DispatchQueue.main.async {
                self.collectionResponse.append(contentsOf: response)
            }
        }
    }
}
