//
//  SearchView.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import SwiftUI

struct SearchView: View {
    
    @State private var text: String = ""
    @State private var searchViewModel: SearchViewModel
    let favoritesViewModel: FavoritesViewModel
    
    init(favoritesViewModel: FavoritesViewModel,
         service: GhibliService = ProductionGhibliService()) {
        self.favoritesViewModel = favoritesViewModel
        _searchViewModel = State(wrappedValue: SearchViewModel(service: service))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                switch searchViewModel.state {
                    case .idle:
                        Text("Your search results will be shown here.")
                            .foregroundStyle(.secondary)
                    
                    case .loading:
                        ProgressView()
                    
                    case .success(let films):
                    FilmListView(favoritesViewModel: favoritesViewModel, films: films)
                    
                    case .failure(let error):
                    Text(error.localizedDescription)
                }
            }
            .navigationTitle("Search Ghibli Movies")
            .searchable(text: $text)
            .task(id: text) { /// `id: text` means: each time text change run the code block inside .task {}
                try? await searchViewModel.search(query: text)
            }
        }
    }
}

#Preview {
    SearchView(favoritesViewModel: FavoritesViewModel(service: MockFavoritesStorage()))
}
