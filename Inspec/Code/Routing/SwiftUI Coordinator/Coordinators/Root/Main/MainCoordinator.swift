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
    
    // MARK: -  This Coordinator specific variables
    var ftueHandler: FTUEHandler = FTUEHandler()
    var rootRoute: TabbarRoutes = .builds
    
    // MARK: -  States
    //@State var statusBarHidden: Bool = false
    //@State var dismiss: Bool = false
    
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
    
    // MARK: - States
    @State var rootView: AnyView!
    
    var tabbarDispatcher: TabbarTabDispatcher {
        return TabbarTabDispatcher(coordinator: self)
    }
    
    init (rootCoordinatorDelegate: RootCoordinatorDelegate = .init()) {
        self.rootCoordinatorDelegate = rootCoordinatorDelegate
        self.router = MainRouter(coordinator: self)
        
        populateChildren()
    }
    
    func coordinatorView() -> AnyView {
        return AnyView(MainCoordinatorView(coordinator: self))
    }
    
    func navigateTo(tab: TabbarRoutes){
        let child = getCoordinatorFor(route: tab)
        present(coordinator: child)
    }
}
