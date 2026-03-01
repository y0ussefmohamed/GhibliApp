//
//  CharacterSectionView.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import Foundation
import SwiftUI

struct CharacterSectionView:  View {
    
    let viewModel: FilmDetailViewModel
    
    var body: some View {
        Group {
            VStack(alignment: .leading, spacing: 12) {
                Text("Characters")
                    .font(.headline)
                
                switch viewModel.state {
                    case .idle: EmptyView()
                    case .loading:  ProgressView()
                        
                    case .success(let people):
                        ForEach(people) { person in
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(person.name)
                                
                                HStack(spacing: 8) {
                                    Label(person.gender, systemImage: "person.fill")
                                    
                                    Text("Age: \(person.age)")
                                    Spacer()
                                    Label(person.eyeColor, systemImage: "eye")
                                    Text("Hair: \(person.hairColor)")
                                }
                                .foregroundColor(.secondary)
                                .font(.caption)
                                .lineLimit(1)
                                
                            }
                        }
                        
                    case .failure(let error):
                    Text(error.localizedDescription)
                            .foregroundStyle(.pink)
                }
            }
        }
    }
}
