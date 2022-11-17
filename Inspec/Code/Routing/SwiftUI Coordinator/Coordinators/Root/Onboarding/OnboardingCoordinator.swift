//
//  OnboardingCoordinator.swift
//  Inspec
//
//  Created by Justin Cook on 11/13/22.
//

import SwiftUI
import UIKit

class OnboardingCoordinator: RootCoordinator {
    typealias Router = OnboardingRouter
    typealias Body = AnyView
    
    unowned var parent: any Coordinator {
        return self
    }
    var children: [any Coordinator] = []
    var rootRoute: OnboardingRoutes = .onboarding
    
    // MARK: - Published
    @Published var router: OnboardingRouter!
    @Published var path = NavigationPath()
    @Published var pathRoutes: [OnboardingRoutes] = []
    @Published var sheetItem: OnboardingRoutes?
    @Published var fullCoverItem: OnboardingRoutes?
    @Published var rootView: AnyView!
    
    // MARK: - Observed
    @ObservedObject var rootCoordinatorDelegate: RootCoordinatorDelegate
    
    init (rootCoordinatorDelegate: RootCoordinatorDelegate = .init()) {
        self.rootCoordinatorDelegate = rootCoordinatorDelegate
        self.router = OnboardingRouter(coordinator: self)
        self.rootView = router.view(for: rootRoute)
    }
    
    func coordinatorView() -> AnyView {
        return AnyView(OnboardingCoordinatorView(coordinator: self))
    }
}
