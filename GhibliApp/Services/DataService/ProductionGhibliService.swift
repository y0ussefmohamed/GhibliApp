//
//  ProductionGhibliService.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import Foundation

final class ProductionGhibliService: GhibliService {
    func fetchFilms() async throws -> [Film] {
        let url = Constants.shared.url
        let films = try await fetch(from: url, type: [Film].self)
        
        return films
    }
    
    func fetchPerson(from URLString: String) async throws -> Person {
        return try await fetch(from: URLString, type: Person.self)
    }
    
    func searchFilm(for searchTerm: String) async throws -> [Film] {
        let allFilms = try await fetchFilms()
                
        return allFilms.filter { film in
            film.title.localizedStandardContains(searchTerm)
        }
    }
    
    // MARK: - Private Functions
    private func fetch<T: Codable>(from url: String, type: T.Type) async throws -> T {
        guard let url = URL(string: url) else { throw APIError.invalideURL }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }
}
