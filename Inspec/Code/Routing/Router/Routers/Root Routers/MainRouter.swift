//
//  MainRouter.swift
//  Inspec
//
//  Created by Justin Cook on 11/15/22.
//

import SwiftUI

class MainRouter: Routable {
    typealias Route = TabbarRoutes
    typealias Body = AnyView
    
    // MARK: -  View Models
    
    // MARK: - Observed
    @ObservedObject var coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        
        initViewModels()
    }
    
    func initViewModels() {
    }
    
    func view(for route: TabbarRoutes) -> AnyView {
        return AnyView(EmptyView())
    }
}
