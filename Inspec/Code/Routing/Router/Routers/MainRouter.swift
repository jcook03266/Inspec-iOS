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
    
    var coordinator: MainCoordinator
    
    // MARK: -  View Models
    @Published var buildsViewModel: BuildsViewModel!
    @Published var componentsViewModel: ComponentsViewModel!
    @Published var commandCenterViewModel: CommandCenterViewModel!
    @Published var exploreViewModel: ExploreViewModel!
    @Published var inboxViewModel: InboxViewModel!
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        
        self.buildsViewModel = BuildsViewModel(coordinator: BuildsCoordinator(parent: coordinator))
        self.componentsViewModel = ComponentsViewModel(coordinator: ComponentsCoordinator(parent: coordinator))
        self.commandCenterViewModel = CommandCenterViewModel(coordinator: CommandCenterCoordinator(parent: coordinator))
        self.exploreViewModel = ExploreViewModel(coordinator: ExploreCoordinator(parent: coordinator))
        self.inboxViewModel = InboxViewModel(coordinator: InboxCoordinator(parent: coordinator))
    }
    
    func view(for route: TabbarRoutes) -> AnyView {
        switch route {
        case .builds:
            return AnyView(BuildsView(viewModel: self.buildsViewModel))
        case .components:
            return AnyView(ComponentsView(viewModel: self.componentsViewModel))
        case .command_center:
            return AnyView(CommandCenterView(viewModel: self.commandCenterViewModel))
        case .explore:
            return AnyView(ExploreView(viewModel: self.exploreViewModel))
        case .inbox:
            return AnyView(InboxView(viewModel: self.inboxViewModel))
        }
    }
}
