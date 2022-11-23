//
//  BuildsCoordinator.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI
import UIKit

class BuildsCoordinator: Coordinator {
    typealias Router = BuildsRouter
    typealias Body = AnyView
    
    unowned let parent: any Coordinator
    var children: [any Coordinator] = []
    var rootRoute: BuildsRoutes = .main
    var rootView: AnyView!
    var deferredDismissalActionStore: [BuildsRoutes : (() -> Void)?] = [:]
    
    // MARK: - Published
    @Published var navigationPath: [BuildsRoutes] = []
    @Published var sheetItem: BuildsRoutes?
    @Published var fullCoverItem: BuildsRoutes?
    
    // MARK: - Published
    @Published var router: BuildsRouter!
    
    // MARK: - States
    @State var statusBarHidden: Bool = false
    
    init (parent: any Coordinator) {
        self.parent = parent
        self.router = BuildsRouter(coordinator: self)
        self.rootView = view(for: rootRoute)
    }
}
