//
//  HomeView.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = FilmsViewModel(service: ProductionGhibliService())

    var body: some View {
        NavigationStack {
            List(viewModel.films) { film in
                VStack(alignment: .leading) {
                    Text(film.title)
                        .font(.headline)
                    Text(film.description)
                        .font(.subheadline)
                        .lineLimit(2)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Ghibli Films")
            .task {
                await viewModel.fetch()
            }
        }
    }
}

#Preview {
    HomeView()
}
