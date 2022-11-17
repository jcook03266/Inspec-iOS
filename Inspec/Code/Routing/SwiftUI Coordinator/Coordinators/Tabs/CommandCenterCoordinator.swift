//
//  CommandCenterCoordinator.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI
import UIKit

class CommandCenterCoordinator: Coordinator {
    typealias Router = MainRouter
    typealias Body = AnyView
    
    unowned let parent: any Coordinator
    var children: [any Coordinator] = []
    
    // MARK: - Published
    @Published var path: NavigationPath = NavigationPath()
    @Published var pathRoutes: [TabbarRoutes] = []
    @Published var sheetItem: TabbarRoutes?
    @Published var fullCoverItem: TabbarRoutes?
    
    // MARK: - Published
    @Published var router: MainRouter!
    @Published var rootView: AnyView!
 
    init (parent: any Coordinator) {
        self.parent = parent
    }
}
