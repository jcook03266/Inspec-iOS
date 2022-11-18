//
//  ComponentsRouter.swift
//  Inspec
//
//  Created by Justin Cook on 11/18/22.
//

import SwiftUI

class ComponentsRouter: Routable {
    typealias Route = ComponentsRoutes
    typealias Body = AnyView
    
    // MARK: -  View Models
    @Published var componentsViewModel: ComponentsViewModel!
    
    // MARK: - Observed
    @ObservedObject var coordinator: ComponentsCoordinator
    
    init(coordinator: ComponentsCoordinator) {
        self.coordinator = coordinator
        
        initViewModels()
    }
    
    func initViewModels() {
        self.componentsViewModel = ComponentsViewModel(coordinator: self.coordinator)
    }
    
    func view(for route: ComponentsRoutes) -> AnyView {
        switch route {
        case .main:
            return AnyView(ComponentsView(viewModel: self.componentsViewModel))
        }
    }
}

