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
    @StateObject var rootCoordinatorDelegate: RootCoordinatorDelegate = .init()
    
    // MARK: - States
    @State var deepLinkTarget: DeepLinkManager.DeepLinkTarget?
    
    private var activeRootCoordinator: any RootCoordinator {
        return rootCoordinatorDelegate.activeRootCoordinator
    }
    
    // MARK: - Debug Environment Properties
    var isDebug: Bool = true
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isDebug {
                    OnboardingCoordinator(rootCoordinatorDelegate: .init()).view(for: .login)
                }
                else {
                    activeRootCoordinator.coordinatorView()
                         .environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
            }
            .onOpenURL { url in
                deepLinkTarget = deepLinkManager.manage(url: url)
            }
            .onAppear {
            }
        }
    }
}
