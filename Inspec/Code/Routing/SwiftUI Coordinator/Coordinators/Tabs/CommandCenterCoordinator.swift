//
//  CommandCenterCoordinator.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI
import UIKit

class CommandCenterCoordinator: Coordinator {
    typealias Router = CommandCenterRouter
    typealias Body = AnyView
    
    unowned let parent: any Coordinator
    var children: [any Coordinator] = []
    var rootRoute: CommandCenterRoutes = .main
    var rootView: AnyView!
    var deferredDismissalActionStore: [CommandCenterRoutes : (() -> Void)?] = [:]
    
    // MARK: - Published
    @Published var navigationPath: [CommandCenterRoutes] = []
    @Published var sheetItem: CommandCenterRoutes?
    @Published var fullCoverItem: CommandCenterRoutes?
    
    // MARK: - Published
    @Published var router: CommandCenterRouter!
    
    // MARK: - States
    @State var statusBarHidden: Bool = false
 
    init (parent: any Coordinator) {
        self.parent = parent
        self.router = CommandCenterRouter(coordinator: self)
        self.rootView = view(for: rootRoute)
    }
}
