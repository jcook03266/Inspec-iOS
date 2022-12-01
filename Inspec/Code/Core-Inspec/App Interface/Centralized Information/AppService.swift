//
//  AppService.swift
//  Inspec
//
//  Created by Justin Cook on 11/30/22.
//

import SwiftUI

/** Singleton centralized service that stands as the reference point for this application*/
open class AppService: ObservableObject {
    static let shared = AppService()
    
    // MARK: - Core Data
    let persistenceController = PersistenceController.shared
    let deepLinkManager = DeepLinkManager()
    
    // MARK: - Published
    @Published var deepLinkTarget: DeepLinkManager.DeepLinkTarget?
    // MARK: - Debug Environment Properties
    @Published var isDebug: Bool = false
    
    // MARK: -  Observed
    @ObservedObject var rootCoordinatorDelegate: RootCoordinatorDelegate = .init()
    
    var activeRootCoordinator: any RootCoordinator {
        return rootCoordinatorDelegate.activeRootCoordinator
    }
    
    private init() {}
}
