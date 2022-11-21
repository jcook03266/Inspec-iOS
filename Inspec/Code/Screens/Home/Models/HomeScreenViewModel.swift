//
//  HomeScreenViewModel.swift
//  Inspec
//
//  Created by Justin Cook on 11/18/22.
//

import SwiftUI
import AVKit

class HomeScreenViewModel: CoordinatedGenericViewModel {
    let id: UUID = UUID()
    typealias coordinator = OnboardingCoordinator
    
    // MARK: - Observed
    @ObservedObject var coordinator: OnboardingCoordinator
    
    // MARK: - Published
    @Published var videoPlaybackCoordinator: LoopingVideoPlayerPlaybackCoordinator!
    
    // MARK: - Assets
    var backgroundVideo = Videos.getVideo(named: .Homescreen_B_Roll),
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
    
    var localizedStringArray: [String] =
    [LocalizedStrings.getLocalizedString(for: .HOME_SCREEN_SUBTITLE_1),
     LocalizedStrings.getLocalizedString(for: .HOME_SCREEN_SUBTITLE_2),
     LocalizedStrings.getLocalizedString(for: .HOME_SCREEN_SUBTITLE_3),
     LocalizedStrings.getLocalizedString(for: .HOME_SCREEN_SUBTITLE_4),
     LocalizedStrings.getLocalizedString(for: .HOME_SCREEN_SUBTITLE_5),
     LocalizedStrings.getLocalizedString(for: .HOME_SCREEN_SUBTITLE_6)
    ]
    
    var initialSubtitleString: String { return localizedStringArray[0] }
    
    // MARK: - Actions
    var loginAction: (() -> Void) {
        return {
            HapticFeedbackDispatcher.interstitialCTAButtonPress()
            self.coordinator.pushView(with: .login)
        }
    }
    var registerAction: (() -> Void) {
        return {
            HapticFeedbackDispatcher.interstitialCTAButtonPress()
            self.coordinator.pushView(with: .signUp)
        }
    }
    var continueAsAGuestAction: (() -> Void) {
        return {
            HapticFeedbackDispatcher.interstitialCTAButtonPress()
            self.coordinator.rootCoordinatorDelegate.switchRootCoordinator()
        }
    }
    
    init(coordinator: OnboardingCoordinator) {
        self.coordinator = coordinator
        self.videoPlaybackCoordinator = .init(playerView: makeLoopingVideoPlayerUIView())
    }
    
    // MARK: - Video player logic / builder
    func makeLoopingVideoPlayerUIView() -> LoopingVideoPlayerUIView {
        return .init(video: self.backgroundVideo)
    }
}
