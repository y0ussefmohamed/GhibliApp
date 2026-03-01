//
//  FavoriteButton.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//


import SwiftUI

struct FavoriteButton: View {
    
    let filmID: String
    let favoritesViewModel: FavoritesViewModel
    
    var isFavorite: Bool {
        favoritesViewModel.isFavorite(filmID)
    }
    
    var body: some View {
        Button {
            favoritesViewModel.toggleFavorite(for: filmID)
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundStyle(isFavorite ? Color.pink : Color.gray)
        }
    }
}

#Preview {
    FavoriteButton(filmID: "1", favoritesViewModel: .example)
}