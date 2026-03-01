//
//  ProductionFavoritesStorage.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//


import Foundation

struct ProductionFavoritesStorage: FavoritesStorage {
    private let favoritesKey = "GhibliExplorer.FavoriteFilms.IDs"
    
    func loadFavorites() -> Set<String> {
        let favoriteIDsArray = UserDefaults.standard.stringArray(forKey: favoritesKey)
        return Set(favoriteIDsArray ?? [])
    }
    
    func save(favoriteIDs: Set<String>) {
        UserDefaults.standard.set(Array(favoriteIDs), forKey: favoritesKey)
    }
}
