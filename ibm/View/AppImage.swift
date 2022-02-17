//
//  AppIcon.swift
//  ibm
//
//  Created by Amit Jain on 2/16/22.
//

import SwiftUI

struct AppImage: View {
    var imageURL:String
    var width:Double
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable()
            case .failure:
                Image(systemName: "photo")
                    .onAppear {
                        print("fetching icon:\(imageURL)  error: \(phase.error.debugDescription)")
                    }
            @unknown default:
                // Since the AsyncImagePhase enum isn't frozen,
                // we need to add this currently unused fallback
                // to handle any new cases that might be added
                // in the future:
                EmptyView()
            }
        }
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth:width)
    }
}
