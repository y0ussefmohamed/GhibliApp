//
//  FilmRow.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import Foundation
import SwiftUI

struct FilmRow: View {
    let favoritesViewModel: FavoritesViewModel
    let film: Film
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImageView(urlPath: film.image)
                .frame(width: 100, height: 150)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(film.title)
                        .bold()
                    
                    Spacer()
                    FavoriteButton(filmID: film.id,
                                   favoritesViewModel: favoritesViewModel)
                    .buttonStyle(.plain)
                    .controlSize(.large)
                }
                .padding(.bottom, 5)
                
                Text("Directed by \(film.director)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Released: \(film.releaseYear)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.top)
        }
    }
}
