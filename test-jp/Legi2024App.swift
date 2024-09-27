//
//  Legi2024App.swift
//  test-jp
//
//  Created by Jérémie on 26/08/2024.
//

import SwiftUI
import SwiftData

@main
struct Legi2024App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ResultDepartment.self,
            ResultatsParParti.self,
            ResultCirconscription.self,
            ResultParCandidat.self,
            ResultDepute.self
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
            DataLoadingView()
        }
        .modelContainer(sharedModelContainer)
    }
}
