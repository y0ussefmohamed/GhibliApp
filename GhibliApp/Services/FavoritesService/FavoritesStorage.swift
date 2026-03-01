//
//  FavoritesStorage.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//


import Foundation

protocol FavoritesStorage {
    func load() -> Set<String>
    func save(favoriteIDs: Set<String>)
}
