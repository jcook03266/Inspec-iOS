//
//  RootCoordinatorDispatcher.swift
//  Inspec
//
//  Created by Justin Cook on 11/17/22.
//

import Foundation

/// Dispatches root coordinators
struct RootCoordinatorDispatcher {
    var delegate: RootCoordinatorDelegate
    
    var onboardingCoordinator: OnboardingCoordinator {
        return OnboardingCoordinator(rootCoordinatorDelegate: delegate)
    }
    
    var mainCoordinator: MainCoordinator {
        return MainCoordinator(rootCoordinatorDelegate: delegate)
    }
    
    init(delegate: RootCoordinatorDelegate) {
        self.delegate = delegate
    }
    
    func getRootCoordinatorFor(root: RootCoordinators) -> any RootCoordinator {
        switch root {
        case .onboardingCoordinator:
            return self.onboardingCoordinator
        case .mainCoordinator:
            return self.mainCoordinator
        }
    }
    
    /// Keeps track of all root coordinators
    enum RootCoordinators: Hashable, CaseIterable {
        case onboardingCoordinator
        case mainCoordinator
    }
}
