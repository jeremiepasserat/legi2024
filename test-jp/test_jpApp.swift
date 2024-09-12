//
//  test_jpApp.swift
//  test-jp
//
//  Created by Jérémie on 26/08/2024.
//

import SwiftUI
import SwiftData

@main
struct test_jpApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            ElaboratedItem.self
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
            TestView()
        }
        .modelContainer(sharedModelContainer)
    }
}
