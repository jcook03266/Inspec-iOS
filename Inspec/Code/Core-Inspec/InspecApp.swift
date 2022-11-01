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
    @ObservedObject var rootCoordinator: RootCoordinator = RootCoordinator()

    var body: some Scene {
        WindowGroup {
            RootCoordinatorView(rootCoordinator: rootCoordinator)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
