//
//  TabBarRootView.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import SwiftUI

struct TabBarRootView: View {
    @State private var filmsViewModel = FilmsViewModel(service: ProductionGhibliService())
    @State private var favoritesViewModel = FavoritesViewModel(service: ProductionFavoritesStorage())
    
    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper") {
                HomeView(filmsViewModel: filmsViewModel, favoritesViewModel: favoritesViewModel)
            }
            
            Tab("Favorites", systemImage: "heart") {
                FavoritesView(filmsViewModel: filmsViewModel, favoritesViewModel: favoritesViewModel)
            }
            
            Tab("Settings", systemImage: "gear") {
                //SettingsScreen()
            }
            
            Tab(role: .search) {
                SearchView(favoritesViewModel: favoritesViewModel)
            }
        }
        .onAppear() {
            Task {
                try await filmsViewModel.fetch()
                favoritesViewModel.loadFavorites()
            }
        }
    }
}

#Preview {
    TabBarRootView()
}
