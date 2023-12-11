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
            AsyncImageView(url: URL(string: photo?.urls.full ?? ""))
        }
    }
}

#Preview {
    ImageDetailsView()
}
