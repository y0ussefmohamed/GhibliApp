//
//  FavoritesViewModel.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import Foundation
import Observation

@Observable
class FavoritesViewModel {
    private(set) var favoriteIDs: Set<String> = []
    let service: FavoritesStorage
    
    init(service: FavoritesStorage) {
        self.service = service
    }
    
    func isFavorite(_ id: String) -> Bool {
        favoriteIDs.contains(id)
    }
    
    func loadFavorites() {
        self.favoriteIDs = service.loadFavorites()
    }
    
    func toggleFavorite(for id: String) {
        if favoriteIDs.contains(id) {
            favoriteIDs.remove(id)
        } else {
            favoriteIDs.insert(id)
        }
        
        save()
    }
    
    private func save() {
        service.save(favoriteIDs: self.favoriteIDs)
    }
    
    //MARK: - Used in Previews
    static var example: FavoritesViewModel {
        let vm = FavoritesViewModel(service: MockFavoritesStorage())
        vm.favoriteIDs = ["2baf70d1-42bb-4437-b551-e5fed5a87abe"]
        
        return vm
    }
}

