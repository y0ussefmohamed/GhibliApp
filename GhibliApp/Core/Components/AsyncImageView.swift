//
//  AsyncImageView.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import SwiftUI

struct AsyncImageView: View {
    
    let url: URL?
    
    init(urlPath: String) {
        self.url = URL(string: urlPath)
    }
    
    init(url: URL?) {
        self.url = url
    }
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
                case .empty:
                    Color(white: 0.8)
                        .overlay {
                            ProgressView()
                                .controlSize(.large)
                        }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                case .failure(_):
                    Text("Could not get image")
                @unknown default:
                    fatalError()
            }
        }
       
    }
}

#Preview("poster image") {
    AsyncImageView(url: URL.convertAssetImage(named: "posterImage"))
        .frame(height: 150)
}

#Preview("banner image") {
    
    let name = "bannerImage"
    let url = URL.convertAssetImage(named: name)
    
    AsyncImageView(url: url)
        .frame(height: 300)
}

