//
//  AppearanceThemeViewModifier.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import Foundation
import SwiftUI

extension View {
    func setAppearanceTheme() -> some View {
        self
            .modifier(AppearanceThemeViewModifier())
    }
}

struct AppearanceThemeViewModifier: ViewModifier {
    
    @AppStorage(UserDefaultsKeys.appearanceTheme) private var appearanceTheme: AppearanceTheme = .system
    
    func body(content: Content) -> some View {
        content
            .preferredColorScheme(scheme())
    }
    
    private func scheme() -> ColorScheme? {
        switch appearanceTheme {
            case .dark: return .dark
            case .light: return .light
            case .system: return nil
        }
    }
}
