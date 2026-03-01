//
//  FavoritesView.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import SwiftUI

struct FavoritesView: View {
    
    let filmsViewModel: FilmsViewModel
    let favoritesViewModel: FavoritesViewModel
    
    var films: [Film] {
       let favorites = favoritesViewModel.favoriteIDs
        switch filmsViewModel.state {
            case .success(let films):
                return films.filter { favorites.contains($0.id) }
            
            default: return []
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    ContentUnavailableView("No Favorites yet", systemImage: "heart")
                } else {
                    FilmListView(favoritesViewModel: favoritesViewModel, films: films)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesView(filmsViewModel: FilmsViewModel.example,
                    favoritesViewModel: FavoritesViewModel.example)
}
