//
//  SearchImagesView.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/4/23.
//

import SwiftUI

struct SearchImagesView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            HStack {
                CustomSearchField(searchText: $searchText)
                
                CustomSearchButton {
                    networkManagerInstance.searchPhotos(query: searchText, page: 1) { response in
                        print(response?.total_pages)
                    }
                }
            }.navigationBarTitle("Search")
            .padding()
        }
    }
}

#Preview {
    SearchImagesView()
}
