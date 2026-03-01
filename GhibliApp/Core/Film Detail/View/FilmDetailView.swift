//
//  FilmDetailView.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//


import SwiftUI

struct FilmDetailView: View {
    
    let film: Film
    let favoritesViewModel: FavoritesViewModel
    
    @State private var viewModel = FilmDetailViewModel(service: ProductionGhibliService())
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 7) {
                
                FilmImageView(urlPath: film.bannerImage)
                    .frame(height: 300)
                    .containerRelativeFrame(.horizontal)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(film.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Grid(alignment: .leading) {
                        InfoRow(label: "Director", value: film.director)
                        InfoRow(label: "Producer", value: film.producer)
                        InfoRow(label: "Release Date", value: film.releaseYear)
                        InfoRow(label: "Running Time", value: "\(film.duration) minutes")
                        InfoRow(label: "Score", value: "\(film.score)/100")
                    }
                    .padding(.vertical, 8)
                    
                    Divider()
                    
                    Text("Description")
                        .font(.headline)
                    
                    Text(film.description)
            
                    Divider()
                    
                    CharacterSectionView(viewModel: viewModel)
                }
                .padding()
            }
        }
        .toolbar {
            FavoriteButton(filmID: film.id,
                           favoritesViewModel: favoritesViewModel)
        }
        .onAppear {
            Task {
                try? await viewModel.fetchPeople(forFilm: film)
            }
        }
    }
}

#Preview {
    NavigationStack {
        FilmDetailView(film: Film.example,
                         favoritesViewModel: FavoritesViewModel(service: MockFavoritesStorage()))
    }
}
