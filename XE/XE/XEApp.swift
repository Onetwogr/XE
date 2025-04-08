//
//  XEApp.swift
//  XE
//
//  Created by Jannis Ellie Gkortsos on 6/2/25.
//


import SwiftUI
import SwiftData

@main
struct ΧΕApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ProfileItem.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
        .modelContainer(sharedModelContainer)
    }
}

