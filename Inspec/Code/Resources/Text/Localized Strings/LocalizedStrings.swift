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
    case TABBAR_BUTTON_BUILDS,
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
         HOME_SCREEN_CONTINUE_AS_A_GUEST_BUTTON
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

