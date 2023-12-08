//
//  ImageDetailsView.swift
//  Pixify
//
//  Created by Rajwinder Singh on 12/7/23.
//

import SwiftUI

struct ImageDetailsView: View {
    var photo: Photo?

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: photo?.urls.full ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ImageDetailsView()
}
