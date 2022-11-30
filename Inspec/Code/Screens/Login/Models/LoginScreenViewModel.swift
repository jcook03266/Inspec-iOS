//
//  LoginScreenViewModel.swift
//  Inspec
//
//  Created by Justin Cook on 11/26/22.
//

import SwiftUI

class LoginScreenViewModel: CoordinatedGenericViewModel {
    var id: UUID = UUID()
    typealias coordinator = OnboardingCoordinator
    
    // MARK: - Observed
    @ObservedObject var coordinator: OnboardingCoordinator
    
    // MARK: - Published / TextField Models
    @Published var username_emailTextFieldModel: SheathedTextFieldModel!
    @Published var passwordTextFieldModel: SheathedTextFieldModel!
    
    // MARK: - Actions
    var backButtonAction: (() -> Void) {
        return { [weak self] in
            guard let self = self
            else { return }
            self.coordinator.popView()
        }
    }
    var resetPasswordAction: (() -> Void) {
        return {}
    }
    var signUpAction: (() -> Void) {
        return {}
    }
    var signInAction: (() -> Void) {
        return {}
    }
    // Third-party Sign in
    var twitterSignInAction: (() -> Void) {
        return {}
    }
    var googleSignInAction: (() -> Void) {
        return {}
    }
    var appleSignInAction: (() -> Void) {
        return {}
    }
    
    // MARK: - Localized Strings
    var titleText: LocalizedStringKey = LocalizedStrings.getLocalizedStringKey(for: .LOGIN_SCREEN_TITLE),
        backButtonText: LocalizedStringKey = LocalizedStrings.getLocalizedStringKey(for: .LOGIN_SCREEN_BACK_BUTTON_TEXT),
        passwordTextFieldTitle: String = LocalizedStrings.getLocalizedString(for: .LOGIN_SCREEN_PASSWORD_TEXTFIELD_TITLE),
        username_emailTextFieldTitle: String = LocalizedStrings.getLocalizedString(for: .LOGIN_SCREEN_USERNAME_EMAIL_TEXTFIELD_TITLE),
        forgotPasswordButtonText: LocalizedStringKey = LocalizedStrings.getLocalizedStringKey(for: .LOGIN_SCREEN_FORGOT_PASSWORD_BUTTON_TEXT),
        signInButtonText: LocalizedStringKey = LocalizedStrings.getLocalizedStringKey(for: .LOGIN_SCREEN_SIGN_IN_BUTTON_TEXT),
        signUpButtonText: LocalizedStringKey = LocalizedStrings.getLocalizedStringKey(for: .LOGIN_SCREEN_SIGN_UP_BUTTON_TEXT),
        accountCreationPromptText: LocalizedStringKey = LocalizedStrings.getLocalizedStringKey(for: .LOGIN_SCREEN_ACCOUNT_CREATION_PROMPT),
        thirdPartySignInPromptText: LocalizedStringKey = LocalizedStrings.getLocalizedStringKey(for: .LOGIN_SCREEN_THIRD_PARTY_SIGN_IN_PROMPT)
    
    // MARK: - Styling
    // Colors
    var backgroundGradient: LinearGradient = Colors.gradient_1,
        formSectionBackgroundColor: Color = Colors.white.0,
        formShadowColor: Color = Colors.shadow_1.0,
        backButtonTextColor: Color = Colors.secondary_1.0,
        passwordResetTextColor: Color = Colors.secondary_1.0,
        signUpPromptTextColor: Color = Colors.text_white.0,
        signInButtonTextColor: Color = Colors.text_white.0,
        signInButtonBackgroundColor: Color = Colors.primary_1.0,
        signUpButtonTextColor: Color = Colors.black.0,
        signUpButtonBackgroundColor: Color = Colors.white.0,
        backgroundDashedCircleTintColor: Color = Colors.primary_1.0,
        titleGradient: LinearGradient = Colors.gradient_1,
        thirdPartySignInPromptTextColor = Colors.text_white.0
    // Fonts
    var titleFont: FontRepository = .heading_2,
    backButtonTextFont: FontRepository = .body_L,
    passwordResetButtonTextFont: FontRepository = .body_S,
        signInButtonTextFont: FontRepository = .body_L,
        signUpPromptTextFont: FontRepository = .body_S,
        thirdPartySignInPromptTextFont: FontRepository = .body_S
    
    // MARK: - Assets
    var twitterLogo: Image = Images.getImage(named: .twitter),
        googleLogo: Image = Images.getImage(named: .google),
        appleLogo: Image = Images.getImage(named: .apple)
    
    init(coordinator: OnboardingCoordinator) {
        self.coordinator = coordinator
        
        setModels()
    }
    
    func setModels() {
        username_emailTextFieldModel = .init()
        username_emailTextFieldModel.configurator { model in
            model.title = "Username / Email"
            model.placeholderText = "user123 / sampleEmail@Test.com"
            model.icon = Icons.getIconImage(named: .person_fill)
            model.keyboardType = .emailAddress
            model.textContentType = .emailAddress
            model.submitLabel = .next
            model.onSubmitAction = { [weak self] in
                guard let self = self else { return }
                
                self.passwordTextFieldModel.focus()
            }
        }
        
        passwordTextFieldModel = .init()
        passwordTextFieldModel.configurator { model in
            model.title = "Password"
            model.placeholderText = "Cr3&TiV3Password!23"
            model.icon = Icons.getIconImage(named: .lock_fill
            )
            model.keyboardType = .asciiCapable
            model.textContentType = .password
            model.submitLabel = .done
            
            model.inFieldButtonIcon = Icons.getIconImage(named: .eye_slash)
            model.protected = true
            model.inFieldButtonAction = {
                model.protected.toggle()
                
                model.inFieldButtonIcon = model.protected ? Icons.getIconImage(named: .eye_slash) : Icons.getIconImage(named: .eye)
            }
        }
    }
}

