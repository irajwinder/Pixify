//
//  TabBarView.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/6/23.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            SearchImagesView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            BookmarkView()
                .tabItem {
                    Label("Bookmark", systemImage: "bookmark")
                }
        }
    }
}

#Preview {
    TabBarView()
}
