//
//  SearchViewModel.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import Foundation
import Observation

@Observable
class SearchViewModel {
    var state: LoadingState<[Film]>
    let dataService: GhibliService
    
    init(service: GhibliService) {
        state = .idle
        self.dataService = service
    }
    
    func search(query: String) async throws {
        guard !query.isEmpty else {
            state = .idle
            return
        }
        
        state = .loading
        
        try? await Task.sleep(for: .milliseconds(500))
        guard !Task.isCancelled else { return }
        
        do {
            let searchResult = try await dataService.searchFilm(for: query)
            state = .success(searchResult)
        } catch {
            state = .failure(error)
            throw error
        }
    }
}
