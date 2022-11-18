//
//  ExploreCoordinator.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI
import UIKit

class ExploreCoordinator: Coordinator {
    typealias Router = ExploreRouter
    typealias Body = AnyView
    
    unowned let parent: any Coordinator
    var children: [any Coordinator] = []
    var rootRoute: ExploreRoutes = .main
    var rootView: AnyView!
    var deferredDismissalActionStore: [ExploreRoutes : (() -> Void)?] = [:]
    
    // MARK: - Published
    @Published var path: NavigationPath = NavigationPath()
    @Published var pathRoutes: [ExploreRoutes] = []
    @Published var sheetItem: ExploreRoutes?
    @Published var fullCoverItem: ExploreRoutes?
    
    // MARK: - Published
    @Published var router: ExploreRouter!
    
    // MARK: - States
    @State var statusBarHidden: Bool = false
    
    init (parent: any Coordinator) {
        self.parent = parent
        self.router = ExploreRouter(coordinator: self)
        self.rootView = view(for: rootRoute)
    }
}

