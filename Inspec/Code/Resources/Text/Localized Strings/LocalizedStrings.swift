//
//  LocalizedStrings.swift
//  Inspec
//
//  Created by Justin Cook on 10/29/22.
//

import Foundation
import SwiftUI

/// Note: If a new string is added to the localization file(s) please update these enums accordingly
// String keys for SwiftUI and compiler time localization
enum LocalizedStringKeys: LocalizedStringKey, CaseIterable {
    case TABBAR_BUTTON_BUILDS,
         TABBAR_BUTTON_COMPONENTS,
         TABBAR_BUTTON_COMMAND_CENTER,
         TABBAR_BUTTON_EXPLORE,
         TABBAR_BUTTON_INBOX
}

// Strings for UIKit and manual localization
enum LocalizedStrings: String, CaseIterable {
    case TABBAR_BUTTON_BUILDS,
         TABBAR_BUTTON_COMPONENTS,
         TABBAR_BUTTON_COMMAND_CENTER,
         TABBAR_BUTTON_EXPLORE,
         TABBAR_BUTTON_INBOX
}

extension LocalizedStrings {
    static func getLocalizedString(for string: LocalizedStrings) -> String {
        return string.rawValue.localized
    }
}

