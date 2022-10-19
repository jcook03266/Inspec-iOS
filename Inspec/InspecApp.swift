//
//  InspecApp.swift
//  Inspec
//
//  Created by Justin Cook on 10/19/22.
//

import SwiftUI

@main
struct InspecApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
