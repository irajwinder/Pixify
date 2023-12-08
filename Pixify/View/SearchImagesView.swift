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

struct SearchImagesView: View {
    @State private var photosResponse: [Photo] = []
    
    @State private var searchText = ""
    @State private var selectedSearchType = SearchType.pictures
    
    @State private var showAlert = false
    @State private var alert: Alert?
    
    @State private var navigateToListView = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack {
                    CustomSearchField(placeholder: "Enter search text", searchText: $searchText)
                    
                    CustomSearchButton {
                        validateSearch()
                    }
                }
                
                Picker("Search Type", selection: $selectedSearchType) {
                    ForEach(SearchType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 200)
            }
            .navigationBarTitle("Search")
            .alert(isPresented: $showAlert) {
                alert!
            }
            .navigationDestination(isPresented: $navigateToListView) {
                ListView(photosResponse: $photosResponse)
            }
            .padding()
            .onAppear {
                photosResponse = []
                let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                print(paths[0])
            }
        }
    }
    
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
        networkManagerInstance.searchPhotos(query: searchText, page: 1) { response in
            guard let response = response?.results else {
                return
            }
            
            photosResponse = response
            navigateToListView = true
        }
    }
    
    func searchCollection() {
        //navigateToListView = true
    }
}

#Preview {
    SearchImagesView()
}
