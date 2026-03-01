//
//  FilmListView.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import SwiftUI

struct FilmListView: View {
    let favoritesViewModel: FavoritesViewModel
    var films: [Film]
    
    var body: some View {
        
        List(films) { film in
            NavigationLink(value: film) {
                FilmRow(favoritesViewModel: favoritesViewModel, film: film)
            }
        }
        .navigationDestination(for: Film.self) { film in
            FilmDetailView(film: film, favoritesViewModel: favoritesViewModel)
        }
    }
}


#Preview {

    @State @Previewable var filmsViewModel = FilmsViewModel(service: MockGhibliService())
    @State @Previewable var favorites = FavoritesViewModel(service: MockFavoritesStorage())
    
    NavigationStack {
        FilmListView(favoritesViewModel: favorites, films: [Film.example, Film.exampleFavorite])
    }
    .task {
        favorites.loadFavorites()
    }
}

