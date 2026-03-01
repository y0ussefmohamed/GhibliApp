//
//  InfoRow.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import Foundation
import SwiftUI


struct InfoRow: View {
    
    let label: String
    let value: String
    
    var body: some View {
        GridRow {
            Text(label)
                .font(.subheadline)
                .fontWeight(.medium)
                .frame(width: 100, alignment: .leading)
            
            Text(value)
                .font(.subheadline)
        }
    }
}
