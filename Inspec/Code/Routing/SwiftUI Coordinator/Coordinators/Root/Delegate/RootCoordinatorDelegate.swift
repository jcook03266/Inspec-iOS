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
    
    // MARK: - Launch Screen Manager
    private var launchScreenManager: LaunchScreenManager = .init()
    
    // MARK: - First time user experience dependency injection
    var ftueHandler: FTUEHandler = FTUEHandler()
    
    // MARK: - Reference values to be used whenever needed
    static var rootSwitchAnimationBlendDuration: CGFloat = 0.75
    
    init() {
        self.dispatcher = .init(delegate: self)
        
        // On-load tasks
        switchToLaunchScreenScene()
        performLaunchScreenBridge()
    }
    
    func performLaunchScreenBridge() {
        launchScreenManager.onComplete { [weak self] in
            guard let self = self else { return }
            
            self.switchActiveRoot(to: .onboardingCoordinator)
        }
    }
    
    /// Transitions the user to the specified scene, with that scene handling any transition animations
    func switchActiveRoot(to root: RootCoordinatorDispatcher.RootCoordinators) {
        guard root != self.activeRoot else { return }
        
        self.activeRoot = root
    }
    
    // MARK: - Convenience functions
    func switchToLaunchScreenScene() {
        switchActiveRoot(to: .launchScreenCoordinator)
    }
    
    func switchToOnboardingScene() {
        switchActiveRoot(to: .onboardingCoordinator)
    }
    
    func switchToMainScene() {
        switchActiveRoot(to: .mainCoordinator)
    }
}
