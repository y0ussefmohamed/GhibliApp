//
//  HomeView.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import SwiftUI

struct HomeView: View {
    let filmsViewModel: FilmsViewModel
    let favoritesViewModel: FavoritesViewModel
    
    
    var body: some View {
        NavigationStack {
            Group {
                switch filmsViewModel.state {
                case .idle:
                    Text("No Films yet")
                    
                case .loading:
                    ProgressView {
                        Text("Loading ...")
                    }
                case .success(let films):
                    FilmListView(favoritesViewModel: favoritesViewModel, films: films)
                case .failure(let error):
                    Text(error.localizedDescription)
                        .foregroundStyle(.pink)
                }
            }
            .navigationTitle("Ghibli Movies")
            .onAppear {
                Task {
                    try await filmsViewModel.fetch()
                }
            }
        }
    }
}

#Preview {
    HomeView(filmsViewModel: FilmsViewModel.example, favoritesViewModel: FavoritesViewModel.example)
}
