//
//  LocalizedStrings.swift
//  Inspec
//
//  Created by Justin Cook on 10/29/22.
//

import Foundation
import SwiftUI

/// Note: If a new string is added to the localization file(s) please update these enums accordingly
enum LocalizedStrings: String, CaseIterable {
    case APP_NAME,
         TABBAR_BUTTON_BUILDS,
         TABBAR_BUTTON_COMPONENTS,
         TABBAR_BUTTON_COMMAND_CENTER,
         TABBAR_BUTTON_EXPLORE,
         TABBAR_BUTTON_INBOX,
         NAVIGATION_BUTTON_SKIP,
         ONBOARDING_PAGE_1_TITLE,
         ONBOARDING_PAGE_1_MESSAGE,
         ONBOARDING_PAGE_2_TITLE,
         ONBOARDING_PAGE_2_MESSAGE,
         ONBOARDING_PAGE_3_TITLE,
         ONBOARDING_PAGE_3_MESSAGE,
         ONBOARDING_PAGE_4_TITLE,
         ONBOARDING_PAGE_4_MESSAGE,
         ONBOARDING_PAGE_4_CTA,
         HOME_SCREEN_TITLE,
         HOME_SCREEN_LOGIN_BUTTON,
         HOME_SCREEN_REGISTER_BUTTON,
         HOME_SCREEN_CONTINUE_AS_A_GUEST_BUTTON,
         HOME_SCREEN_SUBTITLE_1,
         HOME_SCREEN_SUBTITLE_2,
         HOME_SCREEN_SUBTITLE_3,
         HOME_SCREEN_SUBTITLE_4,
         HOME_SCREEN_SUBTITLE_5,
         HOME_SCREEN_SUBTITLE_6,
         LOGIN_SCREEN_TITLE,
         LOGIN_SCREEN_BACK_BUTTON_TEXT,
         LOGIN_SCREEN_PASSWORD_TEXTFIELD_TITLE,
         LOGIN_SCREEN_USERNAME_EMAIL_TEXTFIELD_TITLE,
         LOGIN_SCREEN_FORGOT_PASSWORD_BUTTON_TEXT,
         LOGIN_SCREEN_SIGN_IN_BUTTON_TEXT,
         LOGIN_SCREEN_SIGN_UP_BUTTON_TEXT,
         LOGIN_SCREEN_ACCOUNT_CREATION_PROMPT,
         LOGIN_SCREEN_THIRD_PARTY_SIGN_IN_PROMPT
}

extension LocalizedStrings {
    /// String keys for SwiftUI and compiler time localization
    static func getLocalizedStringKey(for key: LocalizedStrings) -> LocalizedStringKey {
        
        return LocalizedStringKey(key.rawValue)
    }
    
    /// Strings for UIKit and manual localization
    static func getLocalizedString(for string: LocalizedStrings) -> String {
        return string.rawValue.localized
    }
}

