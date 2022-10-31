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
    @StateObject var mainRouter = ViewRouter()

    var body: some Scene {
        WindowGroup {
            ContentView(router: mainRouter)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
