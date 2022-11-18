//
//  OnboardingRouter.swift
//  Inspec
//
//  Created by Justin Cook on 11/15/22.
//

import SwiftUI

class OnboardingRouter: Routable {
    typealias Route = OnboardingRoutes
    typealias Body = AnyView
    
    // MARK: -  View Models
    @Published var onboardingViewModel: VOCViewModel!
    
    // MARK: - Observed
    @ObservedObject var coordinator: OnboardingCoordinator
    
    init(coordinator: OnboardingCoordinator) {
        self.coordinator = coordinator
        
        initViewModels()
    }
    
    func initViewModels() {
        self.onboardingViewModel = VOCViewModel()
    }
    
    func view(for route: OnboardingRoutes) -> AnyView {
        switch route {
        case .onboarding:
            let progressBarCoordinator: ProgressBarNavigationCoordinator<VOCViewModel> = .init(viewModel: onboardingViewModel, progressBar: onboardingViewModel.progressBar)
            
            progressBarCoordinator.injectProgressViewOnTapActions()
            
            return AnyView(VOC(coordinator: self.coordinator,
                               model: self.onboardingViewModel,
                               PBNCoordinator: progressBarCoordinator,
                               progressBarModel: self.onboardingViewModel.progressBar))
        case .home:
            return AnyView(EmptyView())
        case .login:
            return AnyView(EmptyView())
        case .signUp:
            return AnyView(EmptyView())
        }
    }
}
