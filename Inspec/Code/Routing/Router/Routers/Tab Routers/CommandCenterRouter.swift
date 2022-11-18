//
//  CommandCenterRouter.swift
//  Inspec
//
//  Created by Justin Cook on 11/18/22.
//

import SwiftUI

class CommandCenterRouter: Routable {
    typealias Route = CommandCenterRoutes
    typealias Body = AnyView
    
    // MARK: -  View Models
    @Published var commandCenterViewModel: CommandCenterViewModel!
    
    // MARK: - Observed
    @ObservedObject var coordinator: CommandCenterCoordinator
    
    init(coordinator: CommandCenterCoordinator) {
        self.coordinator = coordinator
        
        initViewModels()
    }
    
    func initViewModels() {
        self.commandCenterViewModel = CommandCenterViewModel(coordinator: self.coordinator)
    }
    
    func view(for route: CommandCenterRoutes) -> AnyView {
        switch route {
        case .main:
            return AnyView(CommandCenterView(viewModel: self.commandCenterViewModel))
        }
    }
}

