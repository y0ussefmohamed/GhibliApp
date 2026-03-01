//
//  SettingsView.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @State private var showAlert: Bool = false
    
    @AppStorage(AppUserDefaultsKeys.appearanceTheme)
    private var appearanceTheme: AppearanceTheme = .system
    
    @AppStorage(AppUserDefaultsKeys.username)
    private var username: String = ""
    
    @AppStorage(AppUserDefaultsKeys.itemsPerPage)
    private var itemsPerPage: Int = 20
    
    @AppStorage(AppUserDefaultsKeys.notificationsEnabled)
    private var notificationsEnabled: Bool = true

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Appearance", selection: $appearanceTheme) {
                        ForEach(AppearanceTheme.allCases) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                } header: {
                    Text("Appearance")
                } footer: {
                    Text("Overrides the system appearance to always use Light.")
                }
                
                Section("Account") {
                    TextField("Username", text: $username)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                
                Section("Preferences") {
                    Stepper("Items per page: \(itemsPerPage)", value: $itemsPerPage, in: 10...100, step: 5)
                    Toggle("Enable notifications", isOn: $notificationsEnabled)
                }
                
                Section {
                    Button(role: .destructive) {
                        showAlert.toggle()
                    } label: {
                        Text("Erase Data & Reset to Defaults")
                    }
                }
            }
            .alert("Are you sure you want to reset all settings?", isPresented: $showAlert, actions: {
                Button("Reset Defaults", role: .destructive) {
                    resetDefaults()
                }
            })
            .navigationTitle("Settings")
        }
    }

    private func resetDefaults() {
        appearanceTheme = .system
        username = ""
        itemsPerPage = 20
        notificationsEnabled = true
    }
}


#Preview {
    NavigationStack {
        SettingsView()
    }
}
