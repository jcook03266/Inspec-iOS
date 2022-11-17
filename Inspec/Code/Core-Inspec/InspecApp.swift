//
//  InspecApp.swift
//  Inspec
//
//  Created by Justin Cook on 10/19/22.
//

import SwiftUI

@main
struct InspecApp: App {
    // MARK: - Core Data
    let persistenceController = PersistenceController.shared
    let deepLinkManager = DeepLinkManager()
    
    // MARK: -  Observed
    @ObservedObject var rootCoordinatorDelegate: RootCoordinatorDelegate = .init()
    
    // MARK: - States
    @State var deepLinkTarget: DeepLinkManager.DeepLinkTarget?
    
    var activeRootCoordinator: any RootCoordinator {
        return rootCoordinatorDelegate.activeRootCoordinator
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                activeRootCoordinator.coordinatorView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            .onOpenURL { url in
                deepLinkTarget = deepLinkManager.manage(url: url)
            }
        }
    }
}
