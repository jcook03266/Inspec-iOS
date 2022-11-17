//
//  RootCoordinator.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI

class RootCoordinatorDelegate: ObservableObject {
    @Published var activeRootCoordinator: (any RootCoordinator)!
    
    var mainCoordinator: MainCoordinator {
        return MainCoordinator(rootCoordinatorDelegate: self)
    }
    var onboardingCoordinator: OnboardingCoordinator {
        return OnboardingCoordinator(rootCoordinatorDelegate: self)
    }
    
    init() {
        //self.coordinator = MainCoordinator()
        self.activeRootCoordinator = onboardingCoordinator
    }
    
    func switchRootCoordinator() {
        if mainCoordinator !== activeRootCoordinator {
            activeRootCoordinator = mainCoordinator
        }
        else {
            activeRootCoordinator = onboardingCoordinator
        }
    }
    
}
