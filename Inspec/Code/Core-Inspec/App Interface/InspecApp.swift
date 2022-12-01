//
//  InspecApp.swift
//  Inspec
//
//  Created by Justin Cook on 10/19/22.
//

import SwiftUI

@main
struct InspecApp: App {
    // MARK: -  Observed
    @StateObject var rootCoordinatorDelegate: RootCoordinatorDelegate = .init()
    @StateObject var appService: AppService = AppService.shared
    
    // MARK: - Convenience variables
    var activeRootCoordinator: any RootCoordinator {
        return appService.rootCoordinatorDelegate.activeRootCoordinator
    }
    var deepLinkManager: DeepLinkManager {
        return appService.deepLinkManager
    }
    var persistenceController: PersistenceController {
        return appService.persistenceController
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if appService.isDebug {
                    OnboardingCoordinator(rootCoordinatorDelegate: .init()).view(for: .home)
                }
                else {
                    appService.activeRootCoordinator.coordinatorView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
            }
            .onOpenURL { url in
                appService.deepLinkTarget = deepLinkManager.manage(url: url)
            }
            .onAppear {
                setup()
            }
        }
    }
    
    private func setup() {
        appService.rootCoordinatorDelegate = self.rootCoordinatorDelegate
    }
    
    func getAppService() -> AppService {
        return self.appService
    }
}
