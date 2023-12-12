//
//  SearchImagesIntent.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/8/23.
//

import SwiftUI

class SearchImagesIntent: ObservableObject {
    @Published var currentPage = 1
    
    @Published var photosResponse: [Photo] = []
    @Published var collectionResponse: [Collection] = []
    @Published var navigateToListView = false
    
    @Published var searchText = ""
    @Published var selectedSearchType = SearchType.pictures
    
    @Published var showAlert = false
    @Published var alert: Alert?
    
    func validateSearch() {
        guard Validation.isValidName(searchText) else {
            showAlert = true
            alert = Validation.showAlert(title: "Error", message: "Enter Search Text")
            return
        }
        
        switch selectedSearchType {
        case .pictures:
            searchPhotos()
        case .collections:
            searchCollection()
        }
    }
    
    func searchPhotos() {
        networkManagerInstance.searchPhotos(query: searchText, page: currentPage) { [weak self] response in
            guard let self = self, let response = response?.results else {
                print("Failed to fetch photos")
                return
            }
            DispatchQueue.main.async {
                self.photosResponse.append(contentsOf: response)
                self.navigateToListView = true
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
                self.navigateToListView = true
            }
        }
    }
}
