//
//  SearchImagesView.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/4/23.
//

import SwiftUI

enum SearchType: String, CaseIterable {
    case pictures = "Photo"
    case collections = "Collections"
}

//Intent
class SearchImagesIntent: ObservableObject {
    @Published var currentPage = 1
    @Published var isLoading = false
    
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
                self.collectionResponse = response
                self.navigateToListView = true
            }
        }
    }
}

// View
struct SearchImagesView: View {
    @StateObject private var stateObject = SearchImagesIntent()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack {
                    CustomSearchField(placeholder: "Enter search text", searchText: $stateObject.searchText)

                    CustomSearchButton {
                        stateObject.validateSearch()
                    }
                }

                Picker("Search Type", selection: $stateObject.selectedSearchType) {
                    ForEach(SearchType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 200)
            }
            .navigationBarTitle("Search")
            .alert(isPresented: $stateObject.showAlert) {
                stateObject.alert!
            }
            .navigationDestination(isPresented: $stateObject.navigateToListView) {
                ListView(observedObject: stateObject)
            }
            .padding()
            .onAppear {
                let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                print(paths[0])
            }
        }
    }
}

#Preview {
    SearchImagesView()
}

//import SwiftUI
//
//enum SearchType: String, CaseIterable {
//    case pictures = "Photo"
//    case collections = "Collections"
//}
//
//struct SearchImagesView: View {
//    @State private var currentPage = 1
//    @State private var isLoading = false
//    
//    @State private var photosResponse: [Photo] = []
//    @State private var collectionResponse: [Collection] = []
//    
//    @State private var searchText = ""
//    @State private var selectedSearchType = SearchType.pictures
//    
//    @State private var showAlert = false
//    @State private var alert: Alert?
//    
//    @State private var navigateToListView = false
//    
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 20) {
//                HStack {
//                    CustomSearchField(placeholder: "Enter search text", searchText: $searchText)
//                    
//                    CustomSearchButton {
//                        validateSearch()
//                    }
//                }
//                
//                Picker("Search Type", selection: $selectedSearchType) {
//                    ForEach(SearchType.allCases, id: \.self) { type in
//                        Text(type.rawValue)
//                    }
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .frame(width: 200)
//            }
//            .navigationBarTitle("Search")
//            .alert(isPresented: $showAlert) {
//                alert!
//            }
//            .navigationDestination(isPresented: $navigateToListView) {
//                ListView(photosResponse: $photosResponse, collectionResponse: $collectionResponse, selectedSearchType: selectedSearchType)
//            }
//            .padding()
//            .onAppear {
//                photosResponse = []
//                let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//                print(paths[0])
//            }
//        }
//    }
//    
//    func validateSearch() {
//        guard Validation.isValidName(searchText) else {
//            showAlert = true
//            alert = Validation.showAlert(title: "Error", message: "Enter Search Text")
//            return
//        }
//        
//        switch selectedSearchType {
//        case .pictures:
//            searchPhotos()
//        case .collections:
//            searchCollection()
//        }
//    }
//    
//    func searchPhotos() {
//        networkManagerInstance.searchPhotos(query: searchText, page: currentPage) { response in
//            guard let response = response?.results else {
//                print("Failed to fetch photos")
//                return
//            }
//            photosResponse.append(contentsOf: response)
//            navigateToListView = true
//        }
//    }
//    
//    func searchCollection() {
//        networkManagerInstance.searchCollection(query: searchText, page: currentPage) { response in
//            guard let response = response?.results else {
//                print("Failed to fetch collections")
//                return
//            }
//            collectionResponse = response
//            navigateToListView = true
//        }
//    }
//}
//
//#Preview {
//    SearchImagesView()
//}
