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
    var state: LoadingState<[Film]>
    let service: GhibliService
    
    init(service: GhibliService) {
        state = .idle
        self.service = service
    }
    
    func fetch() async throws {
        guard !state.isLoading || state.error != nil else { return } /// if is loading or there is an error don't fetch again
        
        state = .loading

        do {
            let films = try await service.fetchFilms()
            state = .success(films)
        } catch {
            state = .failure(APIError.networkError(error))
            throw APIError.networkError(error)
        }
    }
    
    // MARK: - Used in Previews
    static var example: FilmsViewModel {
        let vm = FilmsViewModel(service: MockGhibliService())
        vm.state = .success([Film.example, Film.exampleFavorite])
        return vm
    }
}
