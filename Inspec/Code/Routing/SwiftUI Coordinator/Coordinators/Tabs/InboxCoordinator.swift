//
//  InboxCoordinator.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI
import UIKit

class InboxCoordinator: Coordinator {
    typealias Router = InboxRouter
    typealias Body = AnyView
    
    unowned let parent: any Coordinator
    var children: [any Coordinator] = []
    var rootRoute: InboxRoutes = .main
    var rootView: AnyView!
    var deferredDismissalActionStore: [InboxRoutes : (() -> Void)?] = [:]
    
    // MARK: - Published
    @Published var path: NavigationPath = NavigationPath()
    @Published var pathRoutes: [InboxRoutes] = []
    @Published var sheetItem: InboxRoutes?
    @Published var fullCoverItem: InboxRoutes?
    
    // MARK: - Published
    @Published var router: InboxRouter!
    
    // MARK: - States
    @State var statusBarHidden: Bool = false
    
    init (parent: any Coordinator) {
        self.parent = parent
        self.router = InboxRouter(coordinator: self)
        self.rootView = view(for: rootRoute)
    }
}

