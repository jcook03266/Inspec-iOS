//
//  OnboardingCoordinatorView.swift
//  Inspec
//
//  Created by Justin Cook on 11/15/22.
//

import SwiftUI

struct OnboardingCoordinatorView: CoordinatedView {
    typealias Router = OnboardingRouter
    typealias Coordinator = OnboardingCoordinator
    
    // MARK: - Observed
    @StateObject var coordinator: OnboardingCoordinator
    
    // MARK: - Navigation States
    @State var sheetItemState: OnboardingRoutes? = nil
    @State var fullCoverItemState: OnboardingRoutes? = nil
    
    var body: some View {
        synchronize(publishedValues: [$coordinator.fullCoverItem, $coordinator.sheetItem],
                    with: [$fullCoverItemState, $sheetItemState]) {
            NavigationStack(path: $coordinator.path) {
                coordinator.rootView
                    .fullScreenCover(item: $fullCoverItemState,
                                     content: { route in coordinator.router.view(for: route) })
                    .sheet(item: $sheetItemState,
                           content: { route in coordinator.router.view(for: route) })
                    .navigationDestination(for: Router.Route.self,
                                           destination: { route in coordinator.router.view(for: route) })
            }
        }
                    .statusBarHidden(coordinator.statusBarHidden)
    }
}
