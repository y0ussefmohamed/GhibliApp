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
    var films: [Film] = [] // instead of using @Published
    private let service: GhibliService
    
    init(service: GhibliService) {
        self.service = service
    }
    
    func fetch() async {
        do {
            films = try await service.fetchFilms()
        } catch {
            print(error)
        }
    }
}
