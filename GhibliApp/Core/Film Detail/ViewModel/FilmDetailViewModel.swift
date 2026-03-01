//
//  FilmDetailViewModel.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import Foundation
import Observation

@Observable
class FilmDetailViewModel {
    var state: downloadingState<[Person]> = .idle
    let dataService: GhibliService
    
    init(service: GhibliService) {
        self.dataService = service
    }
    
    func fetchPeople(forFilm film: Film) async throws {
        guard !state.isLoading || state.error != nil else { return }
        
        state = .loading
        var loadedPeople: [Person] = []

        do { /// fetch in parallel
            try await withThrowingTaskGroup(of: Person.self) { group in
                for personURL in film.people {
                    group.addTask {
                        let person = try await self.dataService.fetchPerson(from: personURL)
                        return person
                    }
                }
                
                for try await person in group {
                    loadedPeople.append(person)
                }
            }
            
            state = .success(loadedPeople)
        } catch let error as APIError {
            self.state = .failure(error)
        } catch {
            self.state = .failure(error)
        }
    }
}
