//
//  BuildsRouter.swift
//  Inspec
//
//  Created by Justin Cook on 11/18/22.
//

import SwiftUI

class BuildsRouter: Routable {
    typealias Route = BuildsRoutes
    typealias Body = AnyView
    
    // MARK: -  View Models
    @Published var buildsViewModel: BuildsViewModel!
    
    // MARK: - Observed
    @ObservedObject var coordinator: BuildsCoordinator
    
    init(coordinator: BuildsCoordinator) {
        self.coordinator = coordinator
        
        initViewModels()
    }
    
    func initViewModels() {
        self.buildsViewModel = BuildsViewModel(coordinator: self.coordinator)
    }
    
    func view(for route: BuildsRoutes) -> AnyView {
        switch route {
        case .main:
            return AnyView(BuildsView(viewModel: self.buildsViewModel))
        }
    }
}
