//
//  ComponentsCoordinator.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI
import UIKit

class ComponentsCoordinator: Coordinator {
    typealias Router = ComponentsRouter
    typealias Body = AnyView
    
    unowned let parent: any Coordinator
    var children: [any Coordinator] = []
    var rootRoute: ComponentsRoutes = .main
    var rootView: AnyView!
    var deferredDismissalActionStore: [ComponentsRoutes : (() -> Void)?] = [:]
    
    // MARK: - Published
    @Published var path: NavigationPath = NavigationPath()
    @Published var pathRoutes: [ComponentsRoutes] = []
    @Published var sheetItem: ComponentsRoutes?
    @Published var fullCoverItem: ComponentsRoutes?
    
    // MARK: - Published
    @Published var router: ComponentsRouter!
    
    // MARK: - States
    @State var statusBarHidden: Bool = false
    
    init (parent: any Coordinator) {
        self.parent = parent
        self.router = ComponentsRouter(coordinator: self)
        self.rootView = view(for: rootRoute)
    }
}
