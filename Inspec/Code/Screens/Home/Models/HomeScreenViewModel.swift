//
//  HomeScreenViewModel.swift
//  Inspec
//
//  Created by Justin Cook on 11/18/22.
//

import SwiftUI

class HomeScreenViewModel: CoordinatedGenericViewModel {
    let id: UUID = UUID()
    typealias coordinator = OnboardingCoordinator
    
    // MARK: - Observed
    @ObservedObject var coordinator: OnboardingCoordinator
    
    // MARK: - Assets
    var backgroundImage = Images.getImage(named: .gamingSetup_1),
        characterPortraitImage = Images.getImage(named: .Ian_Dashed_Border_Portrait),
        continueAsGuestIcon = Icons.getIconImage(named: .ghost)
    
    // MARK: Styling
    // Color
    var backgroundTintColor = Colors.black_45.0,
        loginButtonBackgroundColor = Colors.primary_1.0,
        loginButtonForegroundColor = Colors.text_white.0,
        registerButtonBackgroundColor = Colors.text_white.0,
        registerButtonForegroundColor = Colors.primary_1.0,
        continueAsGuestForegroundColor = Colors.text_white.0,
        ghostIconTintColor = Colors.text_white.0,
        titleGradient = Colors.gradient_2
    // Fonts
    var titleFont: FontRepository = .heading_0,
        continueAsGuestFont: FontRepository = .body_M_Bold,
        loginButtonFont: FontRepository = .body_M_Bold,
        registerButtonFont: FontRepository = .body_M_Bold
    
    // MARK: - Localized Text
    let title: LocalizedStringKey = LocalizedStrings.getLocalizedStringKey(for: .HOME_SCREEN_TITLE),
    loginButtonText = LocalizedStrings.getLocalizedStringKey(for: .HOME_SCREEN_LOGIN_BUTTON),
    registerButtonText = LocalizedStrings.getLocalizedStringKey(for: .HOME_SCREEN_REGISTER_BUTTON),
    continueAsGuestText = LocalizedStrings.getLocalizedStringKey(for: .HOME_SCREEN_CONTINUE_AS_A_GUEST_BUTTON)
    
    // MARK: - Actions
    var loginAction: (() -> Void) {
        return {
            self.coordinator.pushView(with: .login)
        }
    }
    var registerAction: (() -> Void) {
        return {
            self.coordinator.pushView(with: .signUp)
        }
    }
    var continueAsAGuestAction: (() -> Void) {
        return {
            self.coordinator.rootCoordinatorDelegate.switchRootCoordinator()
        }
    }
    
    init(coordinator: OnboardingCoordinator) {
        self.coordinator = coordinator
    }
    
}
