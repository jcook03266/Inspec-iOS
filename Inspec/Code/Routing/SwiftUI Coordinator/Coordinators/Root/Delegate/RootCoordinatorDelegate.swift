//
//  RootCoordinator.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI

class RootCoordinatorDelegate: ObservableObject {
    // MARK: - Published
    @Published var activeRoot: RootCoordinatorDispatcher.RootCoordinators!
    
    // MARK: - Root Coordinator management
    private var dispatcher: RootCoordinatorDispatcher!
    var activeRootCoordinator: any RootCoordinator {
        return dispatcher.getRootCoordinatorFor(root: activeRoot)
    }
    
    // MARK: - First time user experience dependency injection
    var ftueHandler: FTUEHandler = FTUEHandler()
    
    init() {
        self.dispatcher = .init(delegate: self)
        self.activeRoot = .onboardingCoordinator
    }
    
    /// Test function that switches between the root coordinators and transitions the user from scene to scene
    func switchRootCoordinator() {
        activeRoot = activeRoot == .mainCoordinator ? .onboardingCoordinator : .mainCoordinator
    }
}
