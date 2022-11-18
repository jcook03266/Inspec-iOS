//
//  MainCoordinator.swift
//  Inspec
//
//  Created by Justin Cook on 11/15/22.
//

import SwiftUI

class MainCoordinator: TabbarCoordinator {
    typealias Router = MainRouter
    typealias Body = AnyView
    
    unowned var parent: any Coordinator {
        return self
    }
    var children: [any Coordinator] = []
    var rootRoute: TabbarRoutes = .builds
    var deferredDismissalActionStore: [TabbarRoutes : (() -> Void)?] = [:]
 
    // MARK: - Observed
    @ObservedObject var rootCoordinatorDelegate: RootCoordinatorDelegate
    
    // MARK: - Published
    @Published var router: MainRouter!
    @Published var currentTab = TabbarRoutes.builds //First tab presented when the user starts up the app
    
    /// These navigation pathways probably won't be used for the main view, another router for each tab will be used for tab specific navigation
    @Published var path = NavigationPath()
    @Published var pathRoutes: [TabbarRoutes] = []
    @Published var sheetItem: TabbarRoutes?
    @Published var fullCoverItem: TabbarRoutes?
    @Published var rootView: AnyView!
    
    // MARK: - States
    @State var statusBarHidden: Bool = false
    
    var tabbarDispatcher: TabbarTabDispatcher {
        return TabbarTabDispatcher(coordinator: self)
    }
    
    init (rootCoordinatorDelegate: RootCoordinatorDelegate = .init()) {
        self.rootCoordinatorDelegate = rootCoordinatorDelegate
        self.router = MainRouter(coordinator: self)
        
        populateChildren()
        
        // Ensure the amount of children equals the amount of tabs currently enumerated
        assert(children.count == TabbarRoutes.allCases.count)
        
        presentRootTab()
    }
    
    func coordinatorView() -> AnyView {
        return AnyView(MainCoordinatorView(coordinator: self))
    }
    
    /// Present the target first tab, this is the first tab the user will see when they enter the app, (mutable)
    func presentRootTab() {
        navigateTo(tab: rootRoute)
    }
    
    func navigateTo(tab: TabbarRoutes){
        currentTab = tab
        
        let child = getCoordinatorFor(route: tab)
        present(coordinator: child)
    }
}
