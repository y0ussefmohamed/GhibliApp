//
//  FilmsViewModel.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import Foundation
import Observation

@Observable
class FilmsViewModel {
    var state: downloadingState<[Film]>
    private let service: GhibliService
    
    init(service: GhibliService) {
        state = .idle
        self.service = service
    }
    
    func fetch() async throws {
        guard !state.isLoading || state.error != nil else { return } /// if is loading or there is an error don't fetch again
        
        do {
            state = .loading
            let films = try await service.fetchFilms()
            state = .success(films)
        } catch {
            state = .failure(APIError.networkError(error))
            throw APIError.networkError(error)
        }
    }
}
