//
//  ExploreRouter.swift
//  Inspec
//
//  Created by Justin Cook on 11/18/22.
//

import SwiftUI

class ExploreRouter: Routable {
    typealias Route = ExploreRoutes
    typealias Body = AnyView
    
    // MARK: -  View Models
    @Published var exploreViewModel: ExploreViewModel!
    
    // MARK: - Observed
    @ObservedObject var coordinator: ExploreCoordinator
    
    init(coordinator: ExploreCoordinator) {
        self.coordinator = coordinator
        
        initViewModels()
    }
    
    func initViewModels() {
        self.exploreViewModel = ExploreViewModel(coordinator: self.coordinator)
    }
    
    func view(for route: ExploreRoutes) -> AnyView {
        switch route {
        case .main:
            return AnyView(ExploreView(viewModel: self.exploreViewModel))
        }
    }
}
