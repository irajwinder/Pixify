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
    @StateObject private var stateObject = SearchImagesIntent()
    @State private var navigateToListView = false
    @State private var showAlert = false
    @State private var alert: Alert?

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack {
                    CustomSearchField(placeholder: "Enter search text", searchText: $stateObject.searchText)

                    CustomSearchButton {
                        validateSearch()
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
            .alert(isPresented: $showAlert) {
                alert!
            }
            .navigationDestination(isPresented: $navigateToListView) {
                ListView(observedObject: stateObject)
            }
            .padding()
            .onAppear {
                stateObject.photosResponse = []
                let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                print(paths[0])
            }
        }
    }
    
    func validateSearch() {
        guard Validation.isValidName(stateObject.searchText) else {
            showAlert = true
            alert = Validation.showAlert(title: "Error", message: "Enter Search Text")
            return
        }
        
        switch stateObject.selectedSearchType {
        case .pictures:
            stateObject.searchPhotos()
            navigateToListView = true
        case .collections:
            stateObject.searchCollection()
            navigateToListView = true
        }
    }
}

#Preview {
    SearchImagesView()
}
