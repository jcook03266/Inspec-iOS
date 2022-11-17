//
//  OnboardingCoordinatorView.swift
//  Inspec
//
//  Created by Justin Cook on 11/15/22.
//

import SwiftUI

struct OnboardingCoordinatorView: View {
    @StateObject var coordinator: OnboardingCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.rootView
                .fullScreenCover(item: $coordinator.fullCoverItem, content: { route in coordinator.router.view(for: route) })
                .sheet(item: $coordinator.sheetItem, content: { route in coordinator.router.view(for: route) })
                .navigationDestination(for: OnboardingRoutes.self, destination: { route in coordinator.router.view(for: route) })
        }
        
    }
}
