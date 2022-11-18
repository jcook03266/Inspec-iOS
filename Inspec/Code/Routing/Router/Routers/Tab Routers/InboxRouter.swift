//
//  InboxRouter.swift
//  Inspec
//
//  Created by Justin Cook on 11/18/22.
//

import SwiftUI

class InboxRouter: Routable {
    typealias Route = InboxRoutes
    typealias Body = AnyView
    
    // MARK: -  View Models
    @Published var inboxViewModel: InboxViewModel!
    
    // MARK: - Observed
    @ObservedObject var coordinator: InboxCoordinator
    
    init(coordinator: InboxCoordinator) {
        self.coordinator = coordinator
        
        initViewModels()
    }
    
    func initViewModels() {
        self.inboxViewModel = InboxViewModel(coordinator: self.coordinator)
    }
    
    func view(for route: InboxRoutes) -> AnyView {
        switch route {
        case .main:
            return AnyView(InboxView(viewModel: self.inboxViewModel))
        }
    }
}
