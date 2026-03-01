//
//  ProductionGhibliService.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import Foundation

enum APIError: LocalizedError {
    case invalideURL
    case invalidResponse
    case decoding(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
            case .invalideURL:
                return "The URL is invalid"
            case .invalidResponse:
                return "Invalid response from server"
            case .decoding(let error):
                return "Failed to decode response: \(error.localizedDescription)"
            case .networkError(let error):
               return "Network error: \(error.localizedDescription)"
        }
    }
}

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
        // TODO
        return []
    }
    
    
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
