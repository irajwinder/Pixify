//
//  Component.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/6/23.
//

import SwiftUI

struct CustomSearchField: View {
    @Binding var searchText: String
    
    var body: some View {
        TextField("Search Images", text: $searchText)
            .padding(8)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct CustomSearchButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.blue)
                .imageScale(.large)
                .padding(8)
        }
    }
}
