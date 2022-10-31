//
//  StringExtensions.swift
//  Inspec
//
//  Created by Justin Cook on 10/29/22.
//

import UIKit

extension String {
    var localized: String {
        let defaultString = "Localization for \(self) not found",
        localizedString = NSLocalizedString(self, value: defaultString, comment: "")
        
        guard defaultString != localizedString else {
            assertionFailure("\(#function), no localized string was found for the string: \(self)")
            return self
        }
        
        return localizedString
    }
}
