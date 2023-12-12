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
                stateObject.photosResponse = []
                let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                print(paths[0])
            }
        }
    }
}

#Preview {
    SearchImagesView()
}
