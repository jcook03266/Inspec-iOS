//
//  LaunchScreenCoordinator.swift
//  Inspec
//
//  Created by Justin Cook on 11/22/22.
//

import SwiftUI
import UIKit

class LaunchScreenCoordinator: RootCoordinator {
    typealias Router = LaunchScreenRouter
    typealias Body = AnyView
    
    unowned var parent: any Coordinator {
        return self
    }
    var children: [any Coordinator] = []
    var rootRoute: LaunchScreenRoutes = .main
    var deferredDismissalActionStore: [LaunchScreenRoutes : (() -> Void)?] = [:]
    
    // MARK: - Published
    @Published var router: LaunchScreenRouter!
    @Published var navigationPath: [LaunchScreenRoutes] = []
    @Published var sheetItem: LaunchScreenRoutes?
    @Published var fullCoverItem: LaunchScreenRoutes?
    @Published var rootView: AnyView!
    @Published var statusBarHidden: Bool = true
    
    // MARK: - Observed
    @ObservedObject var rootCoordinatorDelegate: RootCoordinatorDelegate
    
    init (rootCoordinatorDelegate: RootCoordinatorDelegate = .init()) {
        self.rootCoordinatorDelegate = rootCoordinatorDelegate
        self.router = LaunchScreenRouter(coordinator: self)
        self.rootView = router.view(for: rootRoute)
        
        UINavigationBar.changeAppearance(clear: true)
    }
    
    func coordinatorView() -> AnyView {
        return AnyView(LaunchScreenCoordinatorView(coordinator: self))
    }
    
    func coordinatedView() -> any CoordinatedView {
        return LaunchScreenCoordinatorView(coordinator: self)
    }
}
