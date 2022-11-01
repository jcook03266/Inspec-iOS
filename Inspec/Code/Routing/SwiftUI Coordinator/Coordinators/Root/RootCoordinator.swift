//
//  RootCoordinator.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI

/// Responsible for presenting the first scene in the application and navigating through the different tabbar screens
class RootCoordinator: Coordinator {
    unowned var parent: any Coordinator {
        return self
    }
    var children: [any Coordinator] = []
    
    // First tab presented when the user starts up the app
    @Published var currentTab = Tabs.builds

    // View Models
    @Published var buildsViewModel: BuildsViewModel!
    @Published var componentsViewModel: ComponentsViewModel!
    @Published var commandCenterViewModel: CommandCenterViewModel!
    @Published var exploreViewModel: ExploreViewModel!
    @Published var inboxViewModel: InboxViewModel!
    
    var tabbarDispatcher: TabbarTabDispatcher {
        return TabbarTabDispatcher(coordinator: self)
    }
    
    init() {
        self.buildsViewModel = BuildsViewModel(coordinator: BuildsCoordinator(parent: self))
    }
    
    func present(animated: Bool,
                 onDismiss: (() -> Void)?)
    {}
    
    func getScreenFor(tab: Tabs) -> some View {
        switch tab {
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
    
    func navigateTo(tab: Tabs){
        self.currentTab = tab
    }
}

enum Tabs: String, CaseIterable, Hashable {
    case builds
    case components
    case command_center
    case explore
    case inbox
}
