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
    @Published var homeScreenViewModel: HomeScreenViewModel!
    @Published var loginScreenViewModel: LoginScreenViewModel!
    
    // MARK: - Observed
    @ObservedObject var coordinator: OnboardingCoordinator
    
    init(coordinator: OnboardingCoordinator) {
        self.coordinator = coordinator
        
        initViewModels()
    }
    
    func initViewModels() {
        self.onboardingViewModel = VOCViewModel(coordinator: self.coordinator)
        self.homeScreenViewModel = HomeScreenViewModel(coordinator: self.coordinator)
        self.loginScreenViewModel = LoginScreenViewModel(coordinator: self.coordinator)
    }
    
    func view(for route: OnboardingRoutes) -> AnyView {
        var view: any View
        var statusBarHidden: Bool = false
         
        switch route {
        case .onboarding:
            let progressBarCoordinator: ProgressBarNavigationCoordinator<VOCViewModel> = .init(viewModel: onboardingViewModel, progressBar: onboardingViewModel.progressBar)
            
            progressBarCoordinator.injectProgressViewOnTapActions()
            
             view = VOC(model: self.onboardingViewModel,
                               PBNCoordinator: progressBarCoordinator,
                               progressBarModel: self.onboardingViewModel.progressBar)
            
            statusBarHidden = true
        case .home:
            let textOscillator: TextOscillator = .init(initialValue: self.homeScreenViewModel.initialSubtitleString)
            textOscillator.stringsToCycleThrough = self.homeScreenViewModel.localizedStringArray
            
            view = HomeScreen(model: self.homeScreenViewModel,
                           textOscillator: textOscillator)
            
            
            statusBarHidden = true
        case .login:
            view = LoginScreen(model: self.loginScreenViewModel)
                    .navigationBarBackButtonHidden(true)

            statusBarHidden = false
        case .signUp:
            view = EmptyView()
            
            statusBarHidden = false
        }
        
        return AnyView(view
            .routerStatusBarVisibilityModifier(visible: statusBarHidden,
                                               coordinator: self.coordinator)
        )
    }
}

