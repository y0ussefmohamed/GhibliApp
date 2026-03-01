//
//  FavoritesStorage.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//


import Foundation

protocol FavoritesStorage {
    func loadFavorites() -> Set<String>
    func save(favoriteIDs: Set<String>)
}
